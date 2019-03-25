class History
  include Mongoid::Document
  field :taken, type: Date
  field :returned, type: Date

  belongs_to :user
  belongs_to :book, counter_cache: :taken_count
end
