class UploadDecorator < ApplicationDecorator
  delegate_all
  
  def created_at
    format_date_time(object.created_at)
  end

  def permission
    permission_to_text(object.permission)
  end

  def select_permission
    Note.permissions.keys.map{|a| [permission_to_text(a), a]}
  end

  def permission_to_text(permission)
    case permission
      when 'agent'
          "Pro Agenta"
      when 'manager'
          "Pro Managera"
      when 'user'
          "Pro Usera"
      else
          "nedefinovaná typ"
    end
  end
end
