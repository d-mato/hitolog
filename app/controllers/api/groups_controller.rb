class Api::GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:show, :update, :destroy]

  def index
    @groups = current_user.groups
  end

  def show
  end

  def create
    group = current_user.groups.build(group_params)
    if group.save
      render json: group
    else
      head :bad_request
    end
  end

  def update
    return head :bad_request unless @group.update(group_params)
  end

  def destroy
    return head :bad_request unless @group.destroy
  end

  private

  def set_group
    @group = current_user.groups.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :sex)
  end
end
