module QueryNodes
  class PropertyNode < Node
    def initialize(key, value)
      @key = key
      @value = value
    end

    def apply(query)
      query.where(@key => @value)
    end
  end
end
