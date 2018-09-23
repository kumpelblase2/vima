class WatchController < ApplicationController
  def index
    @video = Video.find(params[:id])
    if params[:playlist]
      @playlist = Playlist.find(params[:playlist])
    elsif params[:smart_playlist]
      @playlist = SmartPlaylist.find(params[:smart_playlist])
    end

    next_video = PlaylistsHelper.get_video_after @playlist, @video
    if next_video
      @next_video = watch_video_path(next_video)
    end
  end
end
