require 'singleton'

class MetadataProviderList
  include Singleton

  def initialize
    @available_providers = {}
    @enabled_providers = []
  end

  def setup(config)
    self.available_providers.each do |provider_name, _|
      self.enable_provider provider_name, config[provider_name] if config.include? provider_name
    end
  end

  def available_providers
    @available_providers
  end

  def enabled_providers
    @enabled_providers
  end

  def enable_provider(name, config)
    provider = available_providers[name]
    provider.configure config
    @enabled_providers << provider
  end

  def register(name, clazz)
    @available_providers[name] = clazz.new
  end

  def run(type, value, save = true, data = {})
    @enabled_providers.each do |provider|
      provider.run(type, value, data)
    end

    value.save! if save
  end

  def enabled_metadata
    @enabled_providers.map(&:metadata).flatten
  end
end
