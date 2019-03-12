Dir[File.dirname(__FILE__) + "/../../app/lib/handlers/*.rb"].each { |file| puts file; require file }

config = Rails.application.config.library["providers"]

MetadataProviderList.instance.setup config
