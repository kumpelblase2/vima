class SmartPlaylist
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::Validations

  field :name

  index({name: 1}, {unique: true})
  validates_uniqueness_of :name

  field :query
  field :order_name, default: 'name'
  field :order_dir, default: 'asc'


  def videos
    SearchHelper.query(Video.order_by(self.order_name => self.order_dir), self.query).to_a
  end

  def as_playlist_param
    { smart_playlist: self.id }
  end
end
