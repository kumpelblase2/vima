module MetadataHelper
  def self.get_configured_metadata
    config_metadata = Rails.configuration.library["metadata"]
    provider_metadata = get_provider_metadata
    config_metadata + provider_metadata
  end

  def self.get_provider_metadata
    MetadataProvider.enabled_metadata
  end

  def self.get_allowed_keys
    get_configured_metadata.map(&:name)
  end

  def self.get_searchable_metadata
    get_configured_metadata.select do |metadata|
      metadata.type == "text"
    end.map(&:name)
  end

  def self.get_updatable_keys
    get_configured_metadata.reject(&:read_only?).map(&:name)
  end
end
