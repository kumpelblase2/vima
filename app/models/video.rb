class Video
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  include Mongoid::Search

  field :location
  field :file_hash
  field :name

  search_in :name, :location, *VideoHelper.get_searchable_metadata
end
