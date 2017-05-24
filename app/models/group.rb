class Group < ApplicationRecord
  belongs_to :user
  has_many :group_people, dependent: :destroy
  has_many :people, through: :group_people

  validates :name, presence: true
end
