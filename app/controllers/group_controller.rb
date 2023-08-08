class GroupController < ApplicationController
    def index
        @groups = Group.all
    end
end
