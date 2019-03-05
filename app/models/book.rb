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
    self.rank = (self.ratings.map{ |r| 1/r.rate.to_f }.inject(0){|rating, r| rating + r}).to_s
    self.save
  end
  
  def voted_by(user)
    self.ratings.find_by(user: user)
  end

  def top_five
    # puts self.stars_count+self.taken_count
  end
end
