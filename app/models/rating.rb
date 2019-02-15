class Rating
  include Mongoid::Document
  field :rate
  
  belongs_to :user
  belongs_to :book, counter_cache: :stars_count

end