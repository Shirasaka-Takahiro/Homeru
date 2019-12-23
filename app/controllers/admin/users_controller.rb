class Admin::UsersController < ApplicationController
    PER = 15

    def index
        @user = User.where.not(id: current_user.id).page(params[:page]).per(PER).search(params[:search])
    end

end
