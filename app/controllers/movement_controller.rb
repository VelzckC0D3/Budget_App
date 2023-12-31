class MovementController < ApplicationController
  def new
    @movement = Movement.new
    @group = params[:group_id]
  end

  def new_mov
    @movement = Movement.new
    @groups = Group.where(user_id: current_user.id)
  end

  def create
    if params[:group_id]
      @group = Group.find(params[:group_id])
      @movement = @group.movements.build(movement_params)
      @movement.user = @group.user
    else
      @movement = current_user.movements.build(movement_params)
      @group = Group.where(user_id: current_user.id)
    end
    if @movement.save
      if params[:group_id]
        redirect_to user_group_path(current_user.id, @group), notice: 'Movement was successfully added.'
      else
        redirect_to user_group_index_path(current_user.id), notice: 'Movement was successfully added.'
      end
    else
      puts 'error'
    end
  end

  def index
    @movements = Movement.includes(:groups).where(user_id: params[:user_id], group_id: params[:group_id])
    @group = Group.includes(:movements).find(params[:group_id])
    @total = @group.movements.sum(:amount)
  end

  def destroy
    @movement = Movement.find(params[:id])
    @movement.destroy
    redirect_to user_group_path(current_user.id, @movement.group.id), notice: 'Movement was successfully deleted.'
  end

  private

  def movement_params
    params.require(:movement).permit(:name, :amount, :group_id)
  end
end
