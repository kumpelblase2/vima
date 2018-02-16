class EventController < ApplicationController
  def handle
    video = Video.find(params[:videoId])
    event = params[:event]
    MetadataProviderList.instance.run(event.to_sym, video)
    video.save
  end
end
