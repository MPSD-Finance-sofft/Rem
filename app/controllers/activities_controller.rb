class ActivitiesController < ApplicationController

  # GET /activities
  # GET /activities.json
  def index
    @activities = Activity.for_user(current_user).order(created_at: :desc).decorate
  end

end
