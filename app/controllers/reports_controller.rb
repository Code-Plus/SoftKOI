class ReportsController < ApplicationController
  def index
      @search = Report.new(params[:search])
  end
  def char
    
  end
end
