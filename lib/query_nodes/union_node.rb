module QueryNodes
  class UnionNode < Node
    def initialize(*args)
      @elements = args
    end

    def apply(query, keys)
      first = @elements.shift.apply(query, keys)
      @elements.reduce(first) { |full, curr| curr.apply(full.union, keys) }
    end
  end
end
