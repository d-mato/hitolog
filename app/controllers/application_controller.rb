class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # before_action { sign_in User.find_by_email!('') } if Rails.env.development?

  def authenticate_user!
    if signed_in?
      super
    else
      redirect_to sign_in_path, status: 401
    end
  end
end
