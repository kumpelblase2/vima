class Video
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic
  include Mongoid::Search

  field :location
  field :file_hash
  field :name
  field :thumbnails, type: Array, default: -> { [] }
  field :selected_thumbnail, type: Integer

  belongs_to :library

  search_in :name, *MetadataHelper.get_searchable_metadata

  def file_name
    File.basename(name) + ".mp4"
  end

  def self.find_by_hash(hash)
    self.where(file_hash: hash).first
  end

  def selected_thumbnail_path
    self.thumbnails[self.selected_thumbnail || 0]
  end
end
