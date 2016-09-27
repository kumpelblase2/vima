module QueryNodes
  class Node
    def apply(model, keys)
    end

    def format_key(key)
      if key.is_a? Symbol
        key
      else
        key.str.to_sym
      end
    end
  end
end
