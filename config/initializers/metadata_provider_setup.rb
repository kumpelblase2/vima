Dir[File.dirname(__FILE__) + "/../../lib/handlers/*.rb"].each { |file| puts file; require file }

config = Rails.application.config.library["providers"]

MetadataProvider.available_providers.each do |provider_name, provider_instance|
  MetadataProvider.enable_provider provider_name, config[provider_name] if config.include? provider_name
end