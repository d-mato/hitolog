require 'rails_helper'

describe Api::PeopleController do
  let!(:user) { FactoryGirl.create :user }

  describe 'GET index' do
    let!(:people) { FactoryGirl.create_list :person, 10, user: user }
    before do
      other = FactoryGirl.create :user
      FactoryGirl.create_list :person, 10, user: other
    end

    it 'redirects if not signed in' do
      get :index, format: :json
      expect(response.status).to eq 401
    end

    it 'assigns @people with my people' do
      sign_in user
      get :index, format: :json
      expect(assigns(:people)).to eq people
    end
  end

  describe 'PATCH update' do
    let(:person) { FactoryGirl.create :person, user: user }
    let!(:groups) { FactoryGirl.create_list(:group, 10, user: user) }
    let(:params) do
      {
        id: person.id,
        person: {
          name: Faker::Team.name
        },
        group_ids: groups.sample(3).map(&:id)
      }
    end
    before { sign_in user }

    it 'can change person name' do
      patch :update, format: :json, params: params
      expect(person.reload.name).to eq params[:person][:name]
    end

    it "can change person's groups" do
      person.update!(group_ids: groups.sample(3).map(&:id))
      patch :update, format: :json, params: params
      expect(person.reload.group_ids).to match_array params[:group_ids]
    end

    it '他のUserのgroupは設定できない' do
      other_group_id = FactoryGirl.create(:group).id
      params[:group_ids] = [other_group_id]
      patch :update, format: :json, params: params
      expect(person.reload.group_ids).not_to include other_group_id
    end
  end
end
