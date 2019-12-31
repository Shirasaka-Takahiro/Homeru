class ReportsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  PER = 5

  def show
    @report = Report.find(params[:id])
    @comment = Comment.new
    @comments = @report.comments
  end

  def index
    @reports = Report.all.order(params[:sort]).page(params[:page]).per(PER).search(params[:search])
    @report = Report.find_by(params[:id])
    @user = User.find_by(params[:id])
  end

  def edit
  end

  def update
  end

  def new
    @report = Report.new
    @report = current_user.reports.build
  end

  def create
    @report = current_user.reports.build(report_params)

    if @report.save
      redirect_to reports_path
      flash[:notice] = "#{current_user.username}さんが#{@report.title}を投稿しました。"
    else
      render :new
    end
    
  end

  def destroy
    @report = Report.find(params[:id])
    @report.destroy
    flash[:notice] = "投稿#{@report.title}を削除しました"
    redirect_to reports_url
  end

  private

  def report_params
    params.require(:report).permit(:title, :image, :content)
  end

end
