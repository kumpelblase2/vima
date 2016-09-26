require 'parslet'

class QueryTransformer < Parslet::Transform
  rule(:exact => simple(:text)) { { exact: text.str.slice(1, text.size - 2) } }
  rule(:expr => { :expr => subtree(:inner) }) { { :expr => inner } }

  rule(:range => subtree(:range)) {
    if range.has_key? :smallerRange
      value = range[:smallerRange]
      QueryNodes::RangeNode.new(value[:key].str, true, Integer(value[:value]))
    elsif range.has_key? :biggerRange
      value = range[:biggerRange]
      QueryNodes::RangeNode.new(value[:key].str, false, Integer(value[:value]))
    else
      raise Exception.new("Couldn't find a range")
    end
  }

  rule(:property => subtree(:text)) {
    QueryNodes::PropertyNode.new(text[:key].str, text[:value].str)
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
      QueryNodes::BooleanNode.new(value[:key].str, false)
    elsif boolean.has_key? :inclusion
      value = boolean[:inclusion]
      QueryNodes::BooleanNode.new(value[:key].str, true)
    else
      raise Exception.new("Couldn't find a boolean")
    end
  }

  rule(:query => subtree(:queries)) {
    if queries.is_a? Array
      text_queries, normal_queries = queries.partition { |q| (not q.is_a? QueryNodes::Node) and q.has_key? :text }
      full_text, simple_text = text_queries.map { |t| t[:text] }.partition { |t| t.has_key? :exact }

      full_text.map! { |t| QueryNodes::TextSearchNode.new(t[:exact], true) }
      simple_text = QueryNodes::TextSearchNode.new(simple_text.map { |s| s[:simple] }.join(' '))

      { query: normal_queries + full_text + [simple_text] }
    else
      { query: [ queries ] }
    end
  }
end