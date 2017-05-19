class Person < ApplicationRecord
  enum sex: { male: 'M', female: 'F' }
end
