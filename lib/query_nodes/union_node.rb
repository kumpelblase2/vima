module QueryNodes
  class UnionNode < Node
    def initialize(*args)
      @elements = args
    end

    def apply(query, keys)
      applicable_elements = @elements.select { |elem| elem.is_applicable?(keys) }
      selectors = applicable_elements.map { |elem| elem.apply(query, keys).selector }

      query.or(*selectors)
    end

    def is_applicable?(keys)
      @elements.any? {|elem| elem.is_applicable?(keys)}
    end
  end
end
