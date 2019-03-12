module QueryNodes
  class BooleanNode < Node
    def initialize(key, included)
      @key = format_key key
      @included = included
    end

    def is_applicable?(keys)
      keys.has_key? @key
    end

    def apply(query, keys)
      metadata = keys[@key]
      if metadata.type == "taglist"
        query.where(:"#{@key}.0".exists => @included)
      elsif metadata.type == "on_off"
        query.where(@key => @included)
      else
        query.where((@included ? @key.ne : @key) => "")
      end
    end
  end
end
