class Api::ImpressionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_impression, only: [:update, :destroy]

  def create
    person = current_user.people.find(params[:person_id])
    @impression = person.impressions.build(impression_params)
    if @impression.save
      render json: person.impressions
    else
      head :bad_request
    end
  end

  def update
    return head :bad_request unless @impression.update(impression_params)
    render action: :show
  end

  def destroy
    return head :bad_request unless @impression.destroy
  end

  private

  def set_impression
    @impression = Impression.find(params[:id])
    return head :bad_request unless @impression.person.user == current_user
  end

  def impression_params
    params.require(:impression).permit(:date, :comment)
  end
end
