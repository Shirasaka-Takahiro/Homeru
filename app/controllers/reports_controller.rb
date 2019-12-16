class ReportsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show]

  def show
    @report = Report.find(params[:id])
  end

  def index
    @reports = Report.all
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
    report = current_user.reports.build(report_params)

    if report.save!
       redirect_to reports_url
       flash[:notice] = "#{report.title}を投稿しました。"
    else
      render "new"
    end
    
  end

  def destroy
  end

  private

  def report_params
    params.require(:report).permit(:title, :image, :content)
  end

end
