class ReportsController < ApplicationController
  def index
    @search = Report.new(params[:search])
  end
  def chart
    @search = Report.new(params[:search])
  end

  def generate_chart
    @date_from = params[:param1]
    @date_to = params[:param2]
    @element = params[:param3]
    @verb = params[:param4]
    @query = params[:param5]
  end
end
