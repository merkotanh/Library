require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to have_field(:email) }
  it { is_expected.to have_field(:encrypted_password) }
  it { is_expected.to have_field(:admin).of_type(Mongoid::Boolean).with_default_value_of(false) }
  
  it { is_expected.to validate_presence_of(:email) }
    
  it { is_expected.to have_many(:comments).with_dependent(:destroy) }
  it { is_expected.to have_many(:histories).with_dependent(:destroy) }
  it { is_expected.to have_many(:ratings) }

end
