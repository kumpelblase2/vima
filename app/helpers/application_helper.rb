module ApplicationHelper
  def import_component(component)
    path = asset_path(component + ".html")
    "<link rel=\"import\" href=\"#{path}\">".html_safe
  end
end
