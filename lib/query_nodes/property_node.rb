module QueryNodes
  class PropertyNode < Node
    def initialize(key, value)
      @key = format_key key
      @value = value
    end

    def apply(query, keys)
      query.where(@key => @value) if keys.include? @key
    end
  end
end
