class NoteDecorator < ApplicationDecorator
  delegate_all

  def autor
  	User.find_by_id(object.user_id).try(:last_name)
  end

  def created_at
    format_date_time(object.created_at)
  end

  def permission
    permission_to_text(object.permission)
  end

  def select_permission(user)
      if user.admin? || user.user?
        Note.permissions.keys.map{|a| [permission_to_text(a), a]}
      elsif user.manager?
        [["Pro Agenta","agent"],["Pro Managera","manager"]]
      elsif user.agent?
        [["Pro Agenta","agent"]]
    end
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
