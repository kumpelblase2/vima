module QueryNodes
  class CombinationNode < Node
    def initialize(*args)
       @elements = args
    end

    def apply(query, keys)
      selectors = @elements.select { |elem| elem.is_applicable?(keys) }.map { |elem| elem.apply(query, keys).selector }
      query.and(*selectors)
    end

    def is_applicable?(keys)
      @elements.any? { |elem| elem.is_applicable?(keys) }
    end
  end
end
