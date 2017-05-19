class Person < ApplicationRecord
  enum sex: { male: 'M', female: 'F' }

  validates :name, presence: true
end
