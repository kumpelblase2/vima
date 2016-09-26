module QueryNodes
  class TextSearchNode < Node
    def initialize(text, exact = false)
      @text = text
      @exact = exact
    end

    def apply(query)
      query.full_text_search(query, match: (@exact ? :all : :any))
    end
  end
end
