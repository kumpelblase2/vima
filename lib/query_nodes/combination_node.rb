module QueryNodes
  class CombinationNode < Node
    def initialize(*args)
       @elements = args
    end

    def apply(query)
      @elements.reduce(query) { |full, curr| curr.apply(full) }
    end
  end
end
