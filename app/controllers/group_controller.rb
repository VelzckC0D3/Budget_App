class GroupController < ApplicationController
  def index
    return unless user_signed_in?

    @groups = Group.includes(:user).where(user_id: current_user.id)
  end

  def new
    @group = Group.new
  end

  def show
    @group = Group.includes(:user).find(params[:id])
  end

  def create
    @group = current_user.groups.build(group_params) # Associate the group with the current user
    if @group.save
      redirect_to user_group_index_path(current_user.id), notice: 'Group was successfully created.'
    else
      render 'new'
    end
  end




  private

  def group_params
    params.require(:group).permit(:name, :icon)
  end
end
