class Person < ApplicationRecord
  enum sex: { male: 'M', female: 'F' }

  belongs_to :user
  has_many :group_people, dependent: :destroy
  has_many :groups, through: :group_people
  has_many :impressions

  validates :name, presence: true
end
