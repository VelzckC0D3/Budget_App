class UserController < ApplicationController
    def index
        @users = User.all
    end
end
