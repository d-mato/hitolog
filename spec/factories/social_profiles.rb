FactoryGirl.define do
  factory :social_profile do
    user
    provider 'google'
    uid '1234567'
    name { Faker::Name.name }
    nickname { Faker::Name.name }
    email { Faker::Internet.email }
    image_url { Faker::Internet.url }
    raw_info ''
  end
end
