class Rating
  include Mongoid::Document
  field :rate
  
  belongs_to :user
  belongs_to :book, counter_cache: :stars_count

  # def stars(n_stars)
  # stars_count + n_stars/5 
  # end
end