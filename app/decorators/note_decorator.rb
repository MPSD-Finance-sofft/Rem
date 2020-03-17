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

  def user_color(user)
    user = user.decorate
    case object.permission
    when 'agent'
      user.agent_note_color
    when 'manager'
      user.manager_note_color
    when 'user'
      user.user_note_color
    when 'admin'
      user.admin_note_color
    end
  end

  def text_color(user)
     user = user.decorate
    case object.permission
    when 'agent'
      user.agent_note_text_color
    when 'manager'
      user.manager_note_text_color
    when 'user'
      user.user_note_text_color
    when 'admin'
      user.admin_note_text_color
    end
  end
end
