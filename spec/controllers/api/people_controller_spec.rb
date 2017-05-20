require 'rails_helper'

describe Api::PeopleController do
  let!(:user) { FactoryGirl.create :user }
  let!(:people) { FactoryGirl.create_list :person, 10, user: user }
  before do
    other = FactoryGirl.create :user
    FactoryGirl.create_list :person, 10, user: other
  end

  describe 'GET index' do
    it 'redirects if not signed in' do
      get :index
      expect(response).to redirect_to '/users/sign_in'
    end

    it 'assigns @people with my people' do
      sign_in user
      get :index
      expect(assigns(:people)).to eq people
    end
  end
end
