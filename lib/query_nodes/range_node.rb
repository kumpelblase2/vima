module QueryNodes
  class RangeNode < Node
    def initialize(key, smaller, value)
      @key = key
      @smaller = smaller
      @value = value
    end

    def apply(query)
      query.where((@key + "." + (@smaller ? "st" : "gt")) => @value)
    end
  end
end
