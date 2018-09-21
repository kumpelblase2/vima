class MetadataProvider
  def initialize
    @handlers = {}
    @metadata = []
  end

  def configure(config)
  end

  def metadata
    @metadata
  end

  def on_video_create(&block)
    register_handler :video_create, block
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

  def on_video_update(&block)
    register_handler :video_update, block
  end

  def on_video_watch_progress(&block)
    register_handler :watch_progress, block
  end

  def run(type, video, data)
    call_handler type, video, data
  end

  private
    def register_handler(type, block)
      @handlers[type] = block
    end

    def call_handler(type, video, data)
      @handlers[type].call(video, data) if @handlers.has_key? type
    end
end
