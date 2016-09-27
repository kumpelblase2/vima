module QueryNodes
  class PropertyNode < Node
    def initialize(key, value)
      @key = format_key key
      @value = value
    end

    def apply(query)
      query.where(@key => @value)
    end
  end
end
