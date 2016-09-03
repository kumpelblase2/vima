class Metadata
  def initialize(name, type, options = {})
    @name = name
    @type = type
    @options = options
  end

  def name
    @name
  end

  def type
    @type
  end

  def options
    @options
  end

  def self.from_hash(hash)
    if hash.size == 1
      key = hash.keys.first
      new(key, hash[key])
    else
      new(hash['name'], hash['type'], hash['options'])
    end
  end

  def to_s
    @name
  end

  def self.allowed_type?(type)
    case type.to_s
      when "number" || "on_off" || "text" || "range" || "select"
        true
      else
        false
    end
  end
end