class HomeController < ApplicationController
  def index
    authenticate_user!
  end

  def sign_in
  end
end
