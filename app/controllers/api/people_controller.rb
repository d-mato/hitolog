class Api::PeopleController < ApplicationController
  before_action :authenticate_user!
  before_action :set_person, only: [:show, :update, :destroy]

  def index
    @people = current_user.people.eager_load(:groups, :impressions).order(Impression.arel_table[:updated_at].desc)
  end

  def show
  end

  def create
    @person = current_user.people.build(person_params)
    if @person.save
      render action: :show
    else
      head :bad_request
    end
  end

  def update
    return head :bad_request unless @person.update(person_params)
    group_ids = current_user.groups.where(id: params[:group_ids]).pluck(:id)
    @person.update(group_ids: group_ids)
    render action: :show
  end

  def destroy
    return head :bad_request unless @person.destroy
  end

  private

  def set_person
    @person = current_user.people.find(params[:id])
  end

  def person_params
    params.require(:person).permit(:name, :sex, :encountered_at)
  end
end
