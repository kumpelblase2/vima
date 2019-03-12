module QueryNodes
  class RangeNode < Node
    def initialize(key, smaller, value)
      @key = format_key key
      @smaller = smaller
      @value = value
    end

    def apply(query, keys, is_and = false)
      metadata = keys[@key]
      if metadata.type == "taglist"
        if @smaller
          query.where(:"#{@key}.#{@value - 1}".exists => false)
        else
          query.where(:"#{@key}.#{@value}".exists => true)
        end
      else
        query.where((@smaller ? @key.lt : @key.gt) => @value)
      end
    end

    def is_applicable?(keys)
      keys.has_key? @key
    end
  end
end
