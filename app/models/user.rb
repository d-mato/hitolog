class User < ApplicationRecord
  devise :database_authenticatable, :recoverable, :trackable, :omniauthable
end
