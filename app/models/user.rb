class User < ApplicationRecord
  devise :database_authenticatable, :recoverable, :trackable, :omniauthable

  has_many :people
end
