class Comment
  include Mongoid::Document
  field :content
  validates :content, presence: true
  belongs_to :user
  belongs_to :book, dependent: :destroy
end
