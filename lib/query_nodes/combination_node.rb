module QueryNodes
  class CombinationNode < Node
    def initialize(*args)
       @elements = args
    end

    def apply(query, keys)
      @elements.reduce(query) { |full, curr| curr.apply(full, keys) }
    end
  end
end
