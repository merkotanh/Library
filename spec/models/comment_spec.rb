require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to have_field(:content) }
  
  it { is_expected.to validate_presence_of(:content) }

  it { is_expected.to belong_to(:book) }
  it { is_expected.to belong_to(:user) }

end
