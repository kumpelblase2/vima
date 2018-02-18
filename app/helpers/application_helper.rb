module ApplicationHelper
  def import_component(component)
    path = asset_path(component + ".html")
    "<link rel=\"import\" href=\"#{path}\">".html_safe
  end

  def select_thumbnail(video)
    # TODO: should select a default empty url
    if video.thumbnails.length > 0 then video.thumbnails[video.selected_thumbnail] else "" end
  end

  def current_controller?(name)
    params[:controller] == name
  end
end
