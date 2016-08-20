class VideoLoadJob < ApplicationJob
  queue_as :default

  def perform(*args)
    config = Rails.application.config
    dir = config.library["dir"]
    found = []

    Dir.chdir(dir) do
      Dir.glob("*.mp4") do |path|
        next unless File.file?(path)
        found << File.join(dir, path)
      end
    end

    found.each { |video| VideoHelper.load_video(video) }
  end
end
