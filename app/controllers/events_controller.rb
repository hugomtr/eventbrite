require 'date'
class EventsController < ApplicationController
  def index
    @events = Event.all
  end
  
  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end
  
  before_action :authenticate_user!, only: [:index]

  def create
    @event = Event.new(event_params)
    @event.update(start_date: DateTime.now ,  user_id:current_user.id )
    respond_to do |format|
      if @event.save
        format.html { redirect_to '/events', notice: "Gossip was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
   
  end

  private
  def event_params
    params.require(:event).permit(:duration,:start_date ,:title, :description, :price,:location, :user_id)
  end

  def authenticate_user
    unless current_user
      flash[:danger] = "Please log in."
      redirect_to root
    end
  end
end
