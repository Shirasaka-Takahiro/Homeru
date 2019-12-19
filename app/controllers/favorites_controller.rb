class FavoritesController < ApplicationController
  def create
    report = Report.find(params[:report_id])
    current_user.like(report)
    flash[:notice] = 'お気に入り登録をしました。'
    redirect_to reports_url
  end

  def destroy
    report = Report.find(params[:report_id])
    current_user.unlike(report)
    flash[:notice] = 'お気に入り解除をしました。'
    redirect_to reports_url
  end
end
