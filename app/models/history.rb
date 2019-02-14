class History
  include Mongoid::Document
  field :taken
  field :returned
  
  belongs_to :user
  belongs_to :book
end
