require 'rails_helper'

RSpec.describe Book, type: :model do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to have_index_for(title: 1) }
  it { is_expected.to have_index_for(author: 1) }
  it { is_expected.to have_field(:status).of_type(Mongoid::Boolean).with_default_value_of(false) }
  
  it { is_expected.to have_many(:comments).with_dependent(:destroy) }
  it { is_expected.to have_many(:histories).with_dependent(:destroy) }
  it { is_expected.to have_many(:ratings).with_dependent(:destroy) }
end
