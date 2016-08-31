class MetadataProvider
  @@available_providers = {}
  @@enabled_providers = []

  def initialize
    @handlers = {}
    @metadata = []
  end

  def configure(config)
  end

  def metadata
    @metadata
  end

  def on_video_load(&block)
    register_handler :video_load, block
  end

  def on_video_start_play(&block)
    register_handler :video_start, block
  end

  def on_video_finish_play(&block)
    register_handler :video_finish, block
  end

  def run(type, video)
    call_handler type, video
  end

  def self.available_providers
    @@available_providers
  end

  def self.enabled_providers
    @@enabled_providers
  end

  def self.enable_provider(name, config)
    provider = available_providers[name]
    provider.configure config
    @@enabled_providers << provider
  end

  def self.register(name, clazz)
    @@available_providers[name] = clazz.new
  end

  def self.run(type, value)
    enabled_providers.each do |provider|
      provider.run(type, value)
    end
  end

  def self.enabled_metadata
    enabled_providers.map do |provider|
      provider.metadata
    end.flatten
  end

  private
    def register_handler(type, block)
      @handlers[type] = block
    end

    def call_handler(type, video)
      @handlers[type].call(video) if @handlers.has_key? type
    end
end