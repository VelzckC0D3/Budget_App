class GroupController < ApplicationController
    def index
        @groups = Group.where(user_id: current_user.id)
    end

    def new
        @group = Group.new
    end

    def create
        @group = Group.new(group_params)
        if @group.save
            redirect_to user_group_index_path(current_user.id), notice: "Group created successfully"
        else
            redirect_to user_group_index_path(current_user.id), alert: "Group creation failed"
        end
    end

    private 

    def group_params
        params.require(:group).permit(:name, :user_id, :icon)
    end

end