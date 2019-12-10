class NotificationsController < ApplicationController
  before_action :set_notification, only: [:show, :edit, :update, :destroy]

  # GET /notifications
  # GET /notifications.json
  def index
    @notifications = Notification.for_user(current_user.id).order(created_at: :desc)
    @notifications =  IndexFilter::IndexServices.new(@notifications,params).perform
    @notifications = @notifications.decorate
  end

  # GET /notifications/1
  # GET /notifications/1.json
  def show
    @notification.deactive
    if @notification.for_user?
      return redirect_to card_user_path(@notification.object_find), notice: @notification.text
    else
      return redirect_to @notification.object_find, notice: @notification.text
    end
  end

  def deactivate_all
    Notification.for_user(current_user).update_all(active: false)
    redirect_to notifications_path(active_state: true)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notification
      @notification = Notification.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def notification_params
      params.require(:notification).permit(:text, :object, :object_id, :user_id, :active)
    end
end
