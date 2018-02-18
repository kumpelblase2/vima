class HomeController < ApplicationController
  def index
    redirect_to action: 'home'
  end

  def home
    @videos = Video.all
  end
end
