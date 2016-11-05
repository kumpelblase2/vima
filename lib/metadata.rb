class Metadata
  def initialize(name, type, readonly = false, options = {})
    @name = name
    @type = type
    @options = options.map { |k,v| [k.to_sym, v] }.to_h
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

  def has_default?
    @options.has_key?(:default) || Metadata.get_default_value(@type, @options) != nil
  end

  def default
    @options[:default] || Metadata.get_default_value(@type, @options)
  end

  def as_param_requirement
    if @type.to_s == "taglist"
      return @name => []
    end

    @type
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
      when "number", "on_off", "text", "range", "select", "taglist"
        true
      else
        false
    end
  end

  def self.get_default_value(type, options = {})
    case type.to_s
      when "number"
        0
      when "on_off"
        false
      when "text"
        ""
      when "taglist"
        []
      when "range"
        (options and options.has_key?(:min) ? options[:min] : 0)
      when "select"
        (options and options.has_key?(:values) ? options[:values].first : nil)
      else
        nil
    end
  end
end