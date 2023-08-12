class GroupController < ApplicationController
  load_and_authorize_resource
  def index
    return unless user_signed_in?

    @groups = Group.where(user_id: current_user.id)
  end

  def new
    @group = Group.new
    @icons = UserIcons::GROUPICONS
  end

  def show
    @group = Group.order(created_at: :desc).find(params[:id])
  end

  def create
    @icons = UserIcons::GROUPICONS
    @group = current_user.groups.build(group_params) # Associate the group with the current user
    if @group.save
      redirect_to user_group_index_path(current_user.id), notice: 'Group was successfully created.'
    else
      render 'new'
    end
  end

  def destroy
    @group = Group.find(params[:id])

    @group.destroy
    redirect_to '/', notice: 'Group was successfully deleted.'
  end

  private

  def group_params
    params.require(:group).permit(:name, :icon)
  end
end
