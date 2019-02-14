class Comment
  include Mongoid::Document
  field :content
  validates_presence_of :content
  belongs_to :user
  belongs_to :book
end
