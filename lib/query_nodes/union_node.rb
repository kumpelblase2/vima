module QueryNodes
  class UnionNode < Node
    def initialize(*args)
      @elements = args
    end

    def apply(query)
      first = @elements.head.apply(query)
      @elements.tail.reduce(first) { |full, curr| curr.apply(full.union) }
    end
  end
end
