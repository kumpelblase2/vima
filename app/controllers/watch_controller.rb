class WatchController < ApplicationController
  def index
    @video = Video.find(params[:id])
    if params[:playlist]
      playlist = Playlist.find(params[:playlist])
      next_video = playlist.video_after(@video)
      if next_video
        @next_video = watch_video_path(next_video)
      end
    elsif params[:smart_playlist]
      playlist = SmartPlaylist.find(params[:smart_playlist])
      next_video = next_video(playlist, @video)
      if next_video
        @next_video = watch_video_path(next_video)
      end
    end
  end

  private
    def next_video(playlist, current)
      if playlist.is_a?(Playlist)
        playlist.video_after(current)
      elsif playlist.is_a?(SmartPlaylist)
        videos = SearchHelper.query(Video, playlist.query).to_a
        current_index = videos.index { |video| video.id == current.id }
        next_index = current_index + 1
        if next_index < videos.size
          videos[next_index]
        end
      end
    end
end
