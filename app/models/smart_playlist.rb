class SmartPlaylist
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::Validations

  field :name

  index({name: 1}, {unique: true})
  validates_uniqueness_of :name

  field :query
end
