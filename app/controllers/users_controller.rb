class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @reports = @user.reports
  end

  def index
  end

  def edit
  end
end
