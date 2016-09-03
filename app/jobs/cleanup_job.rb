class CleanupJob < ApplicationJob
  queue_as :default

  def perform(*args)
    config = Rails.application.config
    dir = config.library["dir"]

    all = Video.all
    unavailable = all.reject do |video|
      loc = video.location
      File.file?(File.join(dir, loc))
    end

    unavailable.each(&:destroy)
  end
end
