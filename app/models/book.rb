class Book
  include Mongoid::Document
  field :title, type: String
  field :author, type: String
  field :description, type: String
  field :image, type: String
  field :status, type: Mongoid::Boolean, default: false
  field :votes, type: Integer, default: 0
end
