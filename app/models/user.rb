class User
  include Mongoid::Document

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""
  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time
  ## Rememberable
  field :remember_created_at, type: Time
  ## Confirmable
  field :confirmation_token,   type: String
  field :confirmed_at,         type: Time
  field :confirmation_sent_at, type: Time
  field :unconfirmed_email,    type: String # Only if using reconfirmable

  field :admin, type: Mongoid::Boolean, default: false

  has_many :comments, dependent: :destroy
  has_many :histories
  has_many :ratings

  def voted(book)
     self.ratings.find_by(book: book)
  end
  
end
