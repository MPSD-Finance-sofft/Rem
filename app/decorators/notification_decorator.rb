class NotificationDecorator < ApplicationDecorator
  delegate_all

  def active_state
  	return "aktivní" if object.active
  	"neaktivní"
  end
end
