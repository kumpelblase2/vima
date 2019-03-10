class Library
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::Validations

  field :path

  index({path: 1}, {unique: true})
  validates_uniqueness_of :path

  has_many :videos
end
