class FavoritesController < ApplicationController

  def create
    report = Report.find(params[:report_id])
    favorite = current_user.favorites.build(report_id: params[:report_id])
    favorite.save
    flash[:notice] = "投稿 #{report.title}をお気に入りしました"
    redirect_to reports_url
  end

  def destroy
    report = Report.find(params[:report_id])
    favorite = Favorite.find_by(report_id: params[:report_id], user_id: current_user.id)
    favorite.destroy
    flash[:notice] = "投稿 #{report.title}のお気に入りを解除しました"
    redirect_to reports_url
  end

end
