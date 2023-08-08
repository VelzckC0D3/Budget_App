class GroupController < ApplicationController
    def index
        @groups = Group.where(user_id: current_user.id)
    end
end
