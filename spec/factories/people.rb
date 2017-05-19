FactoryGirl.define do
  factory :person do
    name { Faker::Name.name }
    sex { [:male, :female].sample }
  end
end
