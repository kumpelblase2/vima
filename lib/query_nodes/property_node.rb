module QueryNodes
  class PropertyNode < Node
    def initialize(key, value)
      @key = format_key key
      if value.start_with?('"') and value.end_with?('"')
        value = value.slice(1, value.size - 2)
      end
      @value = value
    end

    def apply(query, keys)
      metadata = keys[@key]
      if metadata.type == "taglist"
        selectors = @value.split(' ').map { |val| query.in(@key => [val]).selector }
        query.and(*selectors)
      elsif metadata.type == "number"
        query.where(@key => @value.to_i)
      else
        query.where(@key => @value)
      end
    end

    def is_applicable?(keys)
      keys.has_key? @key
    end
  end
end
