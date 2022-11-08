class ActivitiesController < ApplicationController
  def index
    @activities = Activity.for_user(current_user).order(created_at: :desc).paginate(page: params[:page]).decorate
  end

  def search_index
  	 @activities = Activity.where("user_id != 1")
  	 @activities = IndexFilter::IndexServices.new(@activities,params).perform
  	 @activities = @activities.includes(:user).order(created_at: :desc).paginate(page: params[:page]).decorate
  end
end
