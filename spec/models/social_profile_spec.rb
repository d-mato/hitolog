require 'rails_helper'

describe SocialProfile do
  let(:social_profile) { FactoryGirl.build :social_profile }
  describe 'validation' do
    subject { social_profile }

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
    let(:auth) do
      {
        'info' => {
          'name' => Faker::Internet.user_name,
          'nickname' => Faker::Name.name,
          'email' => Faker::Internet.email,
          'info' => Faker::Internet.url,
        },
        'extra' => {
          'raw_info' => ''
        }
      }
    end
    before { social_profile.oauth_data = auth }
    subject { social_profile }

    it { is_expected.to have_attributes(name: auth['info']['name'], nickname: auth['info']['nickname'], email: auth['info']['email'], image_url: auth['info']['image_url']) }
  end
end
