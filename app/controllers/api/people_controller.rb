class Api::PeopleController < ApplicationController
  before_action :authenticate_user!
  before_action :set_person, only: [:show, :update, :destroy]

  def index
    @people = current_user.people
    render json: @people
  end

  def show
    render json: @person
  end

  def create
    person = current_user.people.build(person_params)
    if person.save
      render json: person
    else
      head :bad_request
    end
  end

  def update
    if @person.update(person_params)
      render json: @person
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

  def person_params
    params.require(:person).permit(:name, :sex)
  end
end
