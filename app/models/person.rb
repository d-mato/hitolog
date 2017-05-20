class Person < ApplicationRecord
  enum sex: { male: 'M', female: 'F' }

  belongs_to :user
  has_many :group_people
  has_many :groups, through: :group_people

  validates :name, presence: true
end
