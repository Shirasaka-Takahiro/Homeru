class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @reports = @user.reports
    @favorites = Favorite.where(user_id: @user.id).all
  end

  def index
  end

  def edit
  end

  def destroy
    user = User.find(params[:id])
    if user.destroy
    redirect_to admin_users_url
    flash[:notice] = "ユーザー「#{user.username}」を削除しました。"
    end
  end


  def likes
    @user = User.find(params[:id])
    @favposts = @user.favposts.page(params[:page])
    counts(@user)
  end

end
