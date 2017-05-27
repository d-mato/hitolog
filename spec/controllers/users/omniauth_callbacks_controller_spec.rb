require 'rails_helper'

describe Users::OmniauthCallbacksController do
  let(:auth) { FactoryGirl.build(:omniauth_auth) }

  describe 'POST google_oauth2' do
    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      @request.env['omniauth.auth'] = auth
    end

    subject { proc { post :google_oauth2 } }

    it 'callback後にUserが作成されていること' do
      expect { subject.call }.to change { User.count }.by(1)
    end

    it 'omniauth情報を元にUserが作成されていること' do
      subject.call
      expect(User.last).to have_attributes(email: auth['info']['email'])
      expect(User.last.social_profiles.last).to have_attributes(provider: auth['provider'], uid: auth['uid'], email: auth['info']['email'], name: auth['info']['name'])
    end

    it 'ログイン状態になっていること' do
      subject.call
      expect(controller.signed_in?).to be true
    end

    describe 'ログイン後' do
      before { subject.call }
      it 'ログアウトした後、再度同じユーザーでログインできること' do
        controller.sign_out
        subject.call
        expect { subject.call }.to change { User.count }.by(0)
        expect(controller.current_user).to eq User.last
      end
    end

    it '別のGoogleアカウントでログインしたら新しいUserが作られること' do
      @request.env['omniauth.auth'] = FactoryGirl.build(:omniauth_auth)
      expect { subject.call }.to change { User.count }.by(1)
    end
  end
end
