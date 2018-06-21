module QueryNodes
  class PropertyNode < Node
    def initialize(key, value)
      @key = format_key key
      @value = value
    end

    def apply(query, keys)
      metadata = keys[@key]
      if metadata.type == "taglist"
        query.in(@key => [@value])
      else
        query.where(@key => @value)
      end
    end

    def is_applicable?(keys)
      keys.has_key? @key
    end
  end
end
