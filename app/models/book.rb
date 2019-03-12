class Book
  include Mongoid::Document
  mount_uploader :image, ImageUploader

  field :title, type: String
  field :author, type: String
  field :description, type: String
  field :image, type: String
  field :status, type: Mongoid::Boolean, default: false
  field :rank, type: String
  field :votes, type: Integer, default: 0
  field :stars_count, type: Integer, default: 0
  field :taken_count, type: Integer, default: 0

  has_many :comments, dependent: :destroy
  has_many :histories
  has_many :ratings, dependent: :destroy

  def count_book_rating(rate)
    self.rank = (self.stars_count/self.ratings.map{ |r| 1/r.rate.to_f }.inject(0){|rating, r| rating + r}).round.to_s
    self.save
  end
  
  # returns true/false if user has voted
  def voted_by?(user_id)
    self.ratings.where(user_id: user_id).exists?
  end

  # returns true/false if book is available or not
  def taken?(user_id)
    self.histories.where(user_id: user_id).and.where(returned: nil).exists?
  end

  # retuns user who took the book
  def taken_by
    self.histories.where(returned: nil).last.user
  end

  # returns -1 if book is not available & taken by user; 0 - if N/A && taken by another user; 1 - book is available
  def taken_by?(user_id)
    self.status ? self.histories.where(user_id: user_id).and.where(returned: nil).exists? ? -1 : 0 : 1
  end
end
