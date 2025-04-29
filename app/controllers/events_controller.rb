# app/controllers/events_controller.rb
class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  
  def index
    @events = current_user.events
  end
  
  def show
    @invitations = @event.invitations.includes(:invitee)
  end
  
  def new
    @event = Event.new
  end
  
  def create
    @event = current_user.events.build(event_params)
    
    if @event.save
      redirect_to @event, notice: 'Event was successfully created.'
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @event.update(event_params)
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      render :edit
    end
  end
  
  def destroy
    @event.destroy
    redirect_to events_path, notice: 'Event was successfully deleted.'
  end
  
  private
  
  def set_event
    @event = current_user.events.find(params[:id])
  end
  
  def event_params
    params.require(:event).permit(:title, :description, :start_time, :end_time, :location)
  end
end
