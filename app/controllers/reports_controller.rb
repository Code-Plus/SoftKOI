class ReportsController < ApplicationController
  def index
      @search = Report.new(params[:search])
  end
end
