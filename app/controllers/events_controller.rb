class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = Event.for_user(current_user).where(start: params[:start]..params[:end])
  end

  def index_list
    @events = Event.for_user(current_user).decorate
  end

  def show
  end

  def new
    @event = Event.new.decorate
    @event.creator = current_user
    @accord_id = params[:accord_id]
  end

  def edit
  end

  def create
    list_of_users = params[:event][:user_id]
    list_of_users.each do |user|
      unless user.blank?
        @event = Event.new(event_params)
        @event.creator = current_user
        @event.user_id = user
        @event.save
      end
    end
  end

  def create_html
    @event = Event.new(event_params)
    @event.user_id = current_user.id if @event.user_id.blank?
    accord_id = params[:accord_id]
    @event.event_text_with_accord(accord_id)
    @event.save
    respond_to do |format|
      if @event.save
        format.html { redirect_to accord_path(id: accord_id), notice: 'Accord was successfully updated.' }
        format.json {}
      else
        format.html { redirect_to accord_path(id: accord_id), notice: 'Accord was successfully updated.' }
        format.json{}
      end
    end
  end

  def update
    @event.update(event_params)
  end

  def destroy
    @event.destroy
  end

  private
    def set_event
      @event = Event.find(params[:id]).decorate
    end

    def event_params
       params.require(:event).permit!
    end
end