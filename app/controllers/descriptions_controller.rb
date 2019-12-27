class DescriptionsController < ApplicationController
  def show
    @description = Description.find(params[:id])
  end

  def index
  end

  def edit
  end
end
