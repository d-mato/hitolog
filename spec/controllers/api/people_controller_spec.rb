require 'rails_helper'

describe Api::PeopleController do
  render_views
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
        person: FactoryGirl.attributes_for(:person),
        group_ids: groups.sample(3).map(&:id)
      }
    end
    before { sign_in user }

    describe 'person.reload' do
      before { patch :update, format: :json, params: params }
      subject { person.reload }

      it { is_expected.to have_attributes(name: params[:person][:name]) }

      it { is_expected.to have_attributes(sex: params[:person][:sex]) }

      it { is_expected.to have_attributes(encountered_at: params[:person][:encountered_at]) }
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

    describe 'response' do
      before { patch :update, format: :json, params: params }
      subject { JSON.parse(response.body).with_indifferent_access }

      it { is_expected.to include(name: params[:person][:name]) }
      it { is_expected.to include(sex: params[:person][:sex]) }
      it { is_expected.to include(encountered_at: params[:person][:encountered_at]) }
    end
  end
end
