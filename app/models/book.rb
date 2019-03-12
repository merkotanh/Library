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
    # self.votes += 1/rate
    # self.rank = self.stars_count/self.votes
    # self.save
    self.rank = (self.stars_count/self.ratings.map{ |r| 1/r.rate.to_f }.inject(0){|rating, r| rating + r}).round.to_s
    self.save
  end
  
  def voted_by?(user_id)
    self.ratings.where(user_id: user_id).exists?
  end

  def taken?(user_id)
    self.histories.where(user_id: user_id).and.where(returned: nil).exists?
  end

  def taken_by?(user_id)
    self.status ? self.histories.where(user_id: user_id).and.where(returned: nil).exists? ? -1 : 0 : 1
  end
end
