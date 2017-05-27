FactoryGirl.define do
  factory :social_profile do
    user nil
    provider "MyString"
    uid "MyString"
    name "MyString"
    nickname "MyString"
    email "MyString"
    image_url "MyString"
    raw_info "MyText"
  end
end
