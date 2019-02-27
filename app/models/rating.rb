class Rating
  include Mongoid::Document

  field :rate, type: Integer, default: 0
  
  belongs_to :user
  belongs_to :book, counter_cache: :stars_count
end
