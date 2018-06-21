module QueryNodes
  class TextSearchNode < Node
    def initialize(text, exact = false)
      @text = text
      @exact = exact
    end

    def apply(query, _keys)
      query.full_text_search(@text, match: (@exact ? :all : :any))
    end

    def is_applicable?(_keys)
      true
    end
  end
end
