class SettingsController < ApplicationController
  def index
    @libraries = Library.all
  end

  def delete_library
    @library = Library.find(params[:id])
    @library.videos.delete_all
    @library.delete
  end

  def create_library
    path = Pathname.new(params[:path]).realpath
    unless path.exist? and path.readable?
      raise "Cannot read"
    end

    if Library.where(path: path.to_s).exists?
      raise "Already exists"
    end

    created = Library.create!(path: path.to_s)
    VideoLoadJob.perform_now(created)
    redirect_to "/settings"
  end
end
