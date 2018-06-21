module QueryNodes
  class BooleanNode < Node
    def initialize(key, included)
      @key = format_key key
      @included = included
    end

    def is_applicable?(keys)
      keys.has_key? @key
    end

    def apply(query, keys)
      query.where(@key => @included)
    end
  end
end
