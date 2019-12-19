class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @reports = @user.reports
  end

  def index
  end

  def edit
  end

  def likes
    @user = User.find(params[:id])
    @favposts = @user.favposts.page(params[:page])
    counts(@user)
  end

end
