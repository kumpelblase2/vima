module MetadataHelper
  def self.get_configured_metadata
    config_metadata = Rails.configuration.library["metadata"]
    provider_metadata = get_provider_metadata
    config_metadata + provider_metadata
  end

  def self.get_metadata_hash(metadata_array)
    metadata_array.reduce({}) { |all, metadata| all[metadata.name.to_sym] = metadata; all }
  end

  def self.get_provider_metadata
    MetadataProviderList.instance.enabled_metadata
  end

  def self.get_allowed_keys
    get_configured_metadata.map(&:name)
  end

  def self.get_searchable_metadata
    get_configured_metadata.select do |metadata|
      metadata.type == "text"
    end.map(&:name)
  end

  def self.get_updatable_parameters
    get_configured_metadata.reject(&:read_only?).map(&:as_param_requirement)
  end

  def self.fix_metadata_types(video)
    get_configured_metadata.reject(&:read_only?).each do |meta|
      value = video[meta.name]
      if meta.type == "taglist" and value == nil
        value = []
        video[meta.name] = []
      end

      if value != nil
        video[meta.name] = meta.format(value)
      end
    end
    video
  end

  def self.apply_defaults(video)
    get_configured_metadata.each do |metadata|
      video[metadata.name] = metadata.default if metadata.has_default?
    end
  end

  def self.get_values_for_metadata(name)
    Video.all.map {|v| v[name]}.flatten.uniq
  end
end
