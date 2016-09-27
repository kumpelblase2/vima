module QueryNodes
  class RangeNode < Node
    def initialize(key, smaller, value)
      @key = format_key key
      @smaller = smaller
      @value = value
    end

    def apply(query, keys)
      query.where((@smaller ? @key.lt : @key.gt) => @value) if keys.include? @key
    end
  end
end
