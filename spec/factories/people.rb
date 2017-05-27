FactoryGirl.define do
  factory :person do
    name { Faker::Name.name }
    sex { ['male', 'female'].sample }
    encountered_at { Faker::Time.backward }
    user
  end
end
