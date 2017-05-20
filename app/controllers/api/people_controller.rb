class Api::PeopleController < ApplicationController
  before_action :authenticate_user!
  before_action :set_person, only: [:show, :update, :destroy]

  def index
    @people = current_user.people
  end

  def show
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
    return head :bad_request unless @person.update(person_params)
  end

  def destroy
    return head :bad_request unless @person.destroy
  end

  private

  def set_person
    @person = current_user.people.find(params[:id])
  end

  def person_params
    params.require(:person).permit(:name, :sex)
  end
end
