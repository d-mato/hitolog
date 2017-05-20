require 'rails_helper'

describe Group do
  let(:group) { FactoryGirl.create :group }
  describe 'has many people' do
    let(:people) { FactoryGirl.create_list(:person, 10, user: group.user) }
    it 'PersonにGroupを追加' do
      people.each { |person| person.groups << group }
      expect(group.reload.people).to eq people
    end
    it 'GroupにPersonを追加' do
      people.each { |person| group.people << person }
      expect(group.reload.people).to eq people
    end

    it 'depends destroy' do
      person = FactoryGirl.create(:person)
      expect { group.people << person }.to change { group.reload.people.count } .by(1)
      expect { person.destroy! }.to change { group.reload.people.count } .by(-1)
    end
  end
end
