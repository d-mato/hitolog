require 'rails_helper'

describe User do
  describe 'has_many people' do
    let(:user) { FactoryGirl.create :user }
    let(:people) { FactoryGirl.create_list :person, 10, user: user }
    before do
      other = FactoryGirl.create :user
      FactoryGirl.create_list :person, 10, user: other
    end

    subject { user.people }
    it { is_expected.to eq people }
  end
end
