module DropdownHelper
  DEFAULT_ORDERING = 'asc'

  def video_ordering_dropdown_item(display_name, attribute)
    selected = params[:order] == attribute
    current_ordering = params[:dir]
    ordering_attributes = VideoHelper.ordering_options(attribute, selected, DEFAULT_ORDERING, current_ordering)
    query_attributes = ordering_attributes.merge({search: params[:search]})
    render_parameters = {
        query_params: query_attributes,
        classes: "dropdown-item #{selected ? 'is-active' : ''}",
        display_name: display_name,
        selected: selected,
        current_order: current_ordering
    }
    render 'shared/dropdown_ordering_item', render_parameters
  end
end
