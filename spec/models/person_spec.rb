require 'rails_helper'

describe Person do
  describe 'enum :sex' do
    it { expect(Person.new(sex: :male).sex).to eq 'male' }
    it { expect(Person.new(sex: :female).sex).to eq 'female' }
    it { expect { Person.new(sex: :foo) }.to raise_error(ArgumentError) }
    describe 'scope' do
      before do
        10.times { FactoryGirl.create :person, sex: [:male, :female].sample }
      end
      it { expect(Person.male.pluck(:sex)).to all eq 'male' }
      it { expect(Person.female.pluck(:sex)).to all eq 'female' }
    end
  end

  describe 'validation' do
    let(:person) { FactoryGirl.build :person }
    subject { person.valid? }
    describe 'name' do
      it 'nameがnilならinvalid' do
        person.name = nil
        is_expected.to be false
      end

      it 'nameが空文字ならinvalid' do
        person.name = ''
        is_expected.to be false
      end

      it 'nameに値が入っていればvalid' do
        person.name = '山田 太郎'
        is_expected.to be true
      end
    end
  end
end
