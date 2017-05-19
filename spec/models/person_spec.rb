require 'rails_helper'

describe Person do
  describe 'enum :sex' do
    it { expect(Person.new(sex: :male).sex).to eq 'male' }
    it { expect(Person.new(sex: :female).sex).to eq 'female' }
    it { expect { Person.new(sex: :foo) }.to raise_error(ArgumentError) }
    describe 'scope' do
      before { FactoryGirl.create_list :person, 10, sex: [:male, :female].sample }
      it { expect(Person.male.pluck(:sex)).to all('male') }
      it { expect(Person.female.pluck(:sex)).to all('female') }
    end
  end
end
