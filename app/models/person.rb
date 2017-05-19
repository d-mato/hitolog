class Person < ApplicationRecord
  enum sex: { male: 'M', female: 'F' }

  belongs_to :user

  validates :name, presence: true
end
