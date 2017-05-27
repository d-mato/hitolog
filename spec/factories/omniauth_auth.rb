FactoryGirl.define do
  factory :omniauth_auth, class: Hash do
    provider 'google_oauth2'
    uid { rand(1_000_000).to_s }
    info do
      {
        name: Faker::Internet.user_name,
        nickname: Faker::Name.name,
        email: Faker::Internet.email,
        image: Faker::Internet.url,
      }
    end
    extra { { raw_info: '' } }

    initialize_with { attributes.with_indifferent_access }
  end
end
