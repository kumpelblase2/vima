class SmartPlaylist
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::Validations

  field :name

  index({name: 1}, {unique: true})
  validates_uniqueness_of :name

  field :query


  def videos
    SearchHelper.query(Video, self.query).to_a
  end

  def as_playlist_param
    { smart_playlist: self.id }
  end
end
