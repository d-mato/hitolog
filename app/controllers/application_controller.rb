class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action { sign_in User.first } if Rails.env.development?

  def index
    authenticate_user!
  end

  def authenticate_user!
    if signed_in?
      super
    else
      redirect_to sign_in_path
    end
  end
end
