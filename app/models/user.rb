class User
  include Mongoid::Document

  devise :database_authenticatable, :registerable, 
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
  field :nickname, type: String
  field :phone, type:String

  has_many :comments, dependent: :destroy
  has_many :histories
  has_many :ratings

  def admin?
    self.admin == true ? true : false
  end

  def books_in_use
    self.histories.where(returned: nil)
  end

  def books_been_read
    self.histories.where(:returned.exists => true)
  end
end
