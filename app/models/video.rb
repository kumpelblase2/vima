class Video
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic
  include Mongoid::Search

  field :location
  field :file_hash
  field :name

  search_in :name, *VideoHelper.get_searchable_metadata

  def file_name
    File.basename(name) + ".mp4"
  end
end
