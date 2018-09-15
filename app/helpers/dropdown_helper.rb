module DropdownHelper
  DEFAULT_ORDERING = Hash.new {|hash, key| hash[key] = 'asc'}

  DEFAULT_ORDERING['created_at'] = 'desc'
  DEFAULT_ORDERING['updated_at'] = 'desc'

  def video_ordering_dropdown_item(display_name, attribute)
    selected = params[:order] == attribute
    current_ordering = params[:dir]
    ordering_attributes = VideoHelper.ordering_options(attribute, selected, DEFAULT_ORDERING[attribute], current_ordering)
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
