Dir[File.dirname(__FILE__) + "/../../lib/*.rb"].each { |file| puts file; require file }
Dir[File.dirname(__FILE__) + "/../../lib/handlers/*.rb"].each { |file| puts file; require file }

config = Rails.application.config.library["providers"]

::MetadataProviders.setup config