module QueryNodes
  class BooleanNode < Node
    def initialize(key, included)
      @key = format_key key
      @included = included
    end

    def apply(query, keys)
      query.where(@key => @included) if keys.has_key? @key
    end
  end
end