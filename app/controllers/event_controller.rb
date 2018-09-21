class EventController < ApplicationController
  def handle
    video = Video.find(params[:videoId])
    event = params[:event]
    data = params[:data]
    MetadataProviderList.instance.run(event.to_sym, video, true, data)
  end
end
