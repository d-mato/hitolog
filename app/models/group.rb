class Group < ApplicationRecord
  belongs_to :user
  has_many :group_people
  has_many :people, through: :group_people
end
