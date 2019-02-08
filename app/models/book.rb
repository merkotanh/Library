class Book
  include Mongoid::Document
  mount_uploader :image, ImageUploader

  field :title, type: String
  field :author, type: String
  field :description, type: String
  field :image, type: String
  field :status, type: Mongoid::Boolean, default: false
  field :votes, type: Integer, default: 0

  has_many :comments, dependent: :destroy
  has_many :histories
  has_many :ratings, dependent: :destroy
end
