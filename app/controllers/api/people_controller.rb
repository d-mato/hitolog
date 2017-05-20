class Api::PeopleController < ApplicationController
  before_action :authenticate_user!

  def index
    @people = current_user.people
    render json: @people
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
  end

  def destroy
  end
end
