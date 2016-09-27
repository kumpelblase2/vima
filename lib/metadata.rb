class Metadata
  def initialize(name, type, readonly = false, options = {})
    @name = name
    @type = type
    @options = options
    @readonly = readonly
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

  def read_only?
    @readonly
  end

  def self.from_hash(hash)
    if hash.size == 1
      key = hash.keys.first
      new(key, hash[key])
    else
      new(hash['name'], hash['type'], hash.fetch('readonly', false), hash.fetch('options', {}))
    end
  end

  def to_s
    @name
  end

  def format(current)
    case @type.to_s
      when "number", "range"
        current.to_i
      when "on_off"
        current == "1" || current == "true"
      else
        current
    end
  end

  def self.allowed_type?(type)
    case type.to_s
      when "number", "on_off", "text", "range", "select"
        true
      else
        false
    end
  end
end