class User < ApplicationRecord
  devise :trackable, :omniauthable

  has_many :groups
  has_many :people
  has_many :social_profiles

  # 与えられたSocialProfileからUserを新規作成し、関連付けを行う
  # 作成に失敗したらnilを返す
  def self.create_with_social_profile!(profile)
    user = new(email: profile.email)
    user.social_profiles << profile
    user.save ? user : nil
  end
end
