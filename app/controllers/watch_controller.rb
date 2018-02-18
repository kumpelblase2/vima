class WatchController < ApplicationController
  def index
    @video = Video.find(params[:id])
    if params[:playlist]
      playlist = Playlist.find(params[:playlist])
      next_video = playlist.video_after(@video)
      if next_video
        @next_video = watch_video_path(next_video)
      end
    end
  end
end
