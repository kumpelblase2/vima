class CleanupJob < ApplicationJob
  queue_as :default

  def perform(*args)
    all = Video.all
    unavailable = all.reject do |video|
      loc = video.location
      File.file?(loc)
    end

    unavailable.each(&:destroy)
  end
end
