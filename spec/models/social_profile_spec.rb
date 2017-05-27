require 'rails_helper'

describe SocialProfile do
  let(:social_profile) { FactoryGirl.build :social_profile }
  subject { social_profile }

  describe 'validation' do
    context 'provider is blank' do
      it do
        subject.provider = nil
        is_expected.to be_invalid
      end
      it do
        subject.provider = ''
        is_expected.to be_invalid
      end
    end

    context 'uid is blank' do
      it do
        subject.uid = nil
        is_expected.to be_invalid
      end
      it do
        subject.uid = ''
        is_expected.to be_invalid
      end
    end

    it 'uidとproviderが同じならinvalid' do
      FactoryGirl.create :social_profile, provider: subject.provider, uid: subject.uid
      is_expected.to be_invalid
    end

    it 'uidが同じでもproviderが違えばvalid' do
      FactoryGirl.create :social_profile, provider: Faker::App.name, uid: subject.uid
      is_expected.to be_valid
    end
  end

  describe '#oauth_data=' do
    let(:auth) { FactoryGirl.build :omniauth_auth }
    before { social_profile.oauth_data = auth }

    it { is_expected.to have_attributes(name: auth['info']['name'], nickname: auth['info']['nickname'], email: auth['info']['email'], image_url: auth['info']['image']) }
  end

  describe 'belongs_to user' do
    let(:user) { FactoryGirl.create :user }
    it '#userがUserインスタンスであること' do
      subject.user_id = user.id
      is_expected.to have_attributes(user: user)
    end
    it '#user_idがnilなら#userはnil' do
      subject.user_id = nil
      is_expected.to have_attributes(user: nil)
    end
  end
end
