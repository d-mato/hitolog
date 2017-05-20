class GroupPerson < ApplicationRecord
  belongs_to :group
  belongs_to :person

  validates :group_id, uniqueness: { scope: :person_id }
end
