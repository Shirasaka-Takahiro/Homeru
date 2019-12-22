class Admin::UsersController < ApplicationController
    PER = 15

    def index
        @user = User.where.not(id: current_user.id)
        @users = User.all.page(params[:page]).per(PER)
    end

end
