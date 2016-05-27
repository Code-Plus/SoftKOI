class EventsController < ApplicationController

  before_action :set_event, only: [:show, :edit, :update, :destroy]
  after_action :day_of_event, only:[:index]
  # after_action :day_of_event, only:[:create]


  def index
    @events = Event.all
    @event = Event.new
  end


  def show
  end

  def new
    @event = Event.new
  end


  def edit
  end


  def create
    @event = Event.create(event_params)

    respond_to do |format|
      if @event.save
        format.json { head :no_content }
        format.js {  flash[:notice] = "¡Evento creada satisfactoriamente!" }
      else
        format.json { render json: @event.errors.full_messages,status: :unprocessable_entity }
      end
    end
  end


  def create_event
    @event = Event.create(event_params)
    respond_to do |format|
      if @event.save
        format.html {redirect_to events_path,notice: 'Evento creado satisfactoriamente.'}
      else
        format.html {redirect_to events_path,notice: '¡Error al crear el evento!'}
      end
    end
  end

  def day_of_event
    unless @events.nil?
      @events.each do |event|
      if event.start_time.strftime("%F") == DateTime.now.strftime("%F")
        activities = PublicActivity::Activity.where(trackable_id: event.id)
        if activities.nil?
          event.create_activity key: 'es su evento para hoy', read_at: nil
        end
      end
      end
     end
  end


  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'El evento ha sido actualizado.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'El evento ha sido eliminado correctamente.' }
      format.json { head :no_content }
    end
  end

  private

    def set_event
      @event = Event.find(params[:id])
    end


    def event_params
      params.require(:event).permit(:description, :start_time, :name)
    end
end
