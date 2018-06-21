module QueryNodes
  class RangeNode < Node
    def initialize(key, smaller, value)
      @key = format_key key
      @smaller = smaller
      @value = value
    end

    def apply(query, keys, is_and = false)
      query.where((@smaller ? @key.lt : @key.gt) => @value)
    end

    def is_applicable?(keys)
      keys.has_key? @key
    end
  end
end
