module ApplicationHelper
  def title(text)
    content_for(:title, text.html_safe)
  end

  def select_thumbnail(video)
    # TODO: should select a default empty url
    if video.thumbnails.length > 0 then video.thumbnails[video.selected_thumbnail] else "" end
  end

  def current_controller?(name)
    params[:controller] == name
  end
end
