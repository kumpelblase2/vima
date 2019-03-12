require 'parslet'

class QueryTransformer < Parslet::Transform
  rule(:exact => simple(:text)) { { exact: text.str.slice(1, text.size - 2) } }
  rule(:expr => { :expr => subtree(:inner) }) { { :expr => inner } }
  rule(:text => subtree(:text)) do
    if text[:exact]
      QueryNodes::TextSearchNode.new(text[:exact], true)
    else
      QueryNodes::TextSearchNode.new(text[:simple])
    end
  end

  rule(:range => subtree(:range)) {
    if range.has_key? :smallerRange
      value = range[:smallerRange]
      typed_value = if value[:value] then Integer(value[:value]) else Date.strptime(value[:date_value], "%Y-%m-%d") end
      QueryNodes::RangeNode.new(value[:key], true, typed_value)
    elsif range.has_key? :biggerRange
      value = range[:biggerRange]
      typed_value = if value[:value] then Integer(value[:value]) else Date.strptime(value[:date_value], "%Y-%m-%d") end
      QueryNodes::RangeNode.new(value[:key], false, typed_value)
    else
      raise Exception.new("Couldn't find a range")
    end
  }

  rule(:property => subtree(:text)) {
    QueryNodes::PropertyNode.new(text[:key], text[:value].str, !text[:negation].nil?)
  }

  rule(:or => subtree(:union)) {
    QueryNodes::UnionNode.new(union[:left], union[:right])
  }

  rule(:and => subtree(:combination)) {
    QueryNodes::CombinationNode.new(combination[:left], combination[:right])
  }

  rule(:boolean => subtree(:boolean)) {
    if boolean.has_key? :exclusion
      value = boolean[:exclusion]
      QueryNodes::BooleanNode.new(value[:key], false)
    elsif boolean.has_key? :inclusion
      value = boolean[:inclusion]
      QueryNodes::BooleanNode.new(value[:key], true)
    else
      raise Exception.new("Couldn't find a boolean")
    end
  }

  rule(:query => subtree(:queries)) {
    queries_array = (queries.is_a?(Array) ? queries : [ queries ])
    { query: queries_array }
  }
end
