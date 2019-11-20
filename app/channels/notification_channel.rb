class NotificationChannel < ApplicationCable::Channel
  def subscribed
    notification = Notification.find params[:notification]
    stream_for notification

    # or
    # stream_from "room_#{params[:room]}"
  end
end