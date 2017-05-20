class Api::PeopleController < ApplicationController
  before_action :authenticate_user!
  before_action :set_person, only: [:show, :destroy]

  def index
    @people = current_user.people
    render json: @people
  end

  def show
    render json: @person
  end

  def create
    person = current_user.people.build(params.require(:person).permit(:name))
    if person.save
      render json: person
    else
      head :bad_request
    end
  end

  def destroy
    if @person.destroy
      render json: @person
    else
      head :bad_request
    end
  end

  private

  def set_person
    @person = current_user.people.find(params[:id])
  end
end
