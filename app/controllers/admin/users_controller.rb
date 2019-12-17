class Admin::UsersController < ApplicationController
    def index
        @user = User.where.not(id: current_user.id)
    end

end
