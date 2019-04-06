class HomeController < ApplicationController
  def index
    redirect_to action: 'home'
  end

  def home
    @videos = Video.order_by(created_at: 'desc').take(video_amount)
  end

  private

  def video_amount
    Settings.get_instance.home_video_count || 12
  end
end
