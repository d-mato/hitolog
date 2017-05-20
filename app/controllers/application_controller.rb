class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # before_action { sign_in User.find_by_email!('') } if Rails.env.development?
end
