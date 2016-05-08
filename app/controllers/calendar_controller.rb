class CalendarController < ApplicationController

  def index
    @calendars = Calendar.all
  end

  def show
    @calendar = Calendar.find(params[:id])
  end

  def new
    @calendar = Calendar.new
    @users = User.all
  end

  def create
    @calendar = Calendar.new(calendar_params)
    respond_to do |format|
      if @calendar.save
        format.json { head :no_content }
        format.js {  flash[:notice] = "¡Recordatorio creado satisfactoriamente!" }
      else
        format.json { render json: @category.errors.full_messages,status: :unprocessable_entity }
      end
    end
  end

  def edit
    @calendar = Calendar.find(params[:id])
    @users = User.all
  end

  def update
    @calendar = Calendar.find(params[:id])
    respond_to do |format|
      if @calendar.update(calendar_params)
        format.json { head :no_content }
        format.js {  flash[:notice] = "¡Recordatorio actualizado satisfactoriamente!" }
      else
        format.json { render json: @category.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def delete
    Calendar.find(params[:id]).destroy
    respond_to do |format|
      format.json { head :no_content }
      format.js {  flash[:notice] = "¡Recordatorio eliminado satisfactoriamente!" }
    end
  end

  private
  def calendar_params
    params.require(:calendars).permit(:date, :description, :title, :hour, :user_id)
  end
end
