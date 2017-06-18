class Impression < ApplicationRecord
  belongs_to :person

  validates :comment, presence: true
  validates :date, presence: true
end
