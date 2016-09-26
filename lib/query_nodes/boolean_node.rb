module QueryNodes
  class BooleanNode < Node
    def initialize(key, included)
      @key = key
      @included = included
    end

    def apply(query)
      query.where(@key => @included)
    end
  end
end