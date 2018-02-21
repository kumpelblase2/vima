class HomeController < ApplicationController
  def index
    redirect_to action: 'home'
  end

  def home
    @videos = Video.order_by(created_at: 'desc').take(video_amount)
  end

  private

  def video_amount
    Rails.configuration.library["home"]["videos"]
  end
end
