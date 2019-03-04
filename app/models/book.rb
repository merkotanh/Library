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
  field :stars_count, type: Integer
  field :taken_count, type: Integer
  has_many :comments, dependent: :destroy
  has_many :histories
  has_many :ratings, dependent: :destroy

  def count_book_rating(book, rate)
    # book.votes += 1/rate
    # book.rank = book.stars_count/book.votes
    # book.save

    book.rank = (book.stars_count/book.ratings.map{ |r| 1/r.rate.to_f }.inject(0){|rating, r| rating + r}).round.to_s
    book.save
  end
  
  def voted_by(user_id)
    self.ratings.where(user_id: user_id).exists?
  end

  def top_five
  end
end
