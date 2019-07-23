class NoteDecorator < ApplicationDecorator
  delegate_all

  def autor
  	User.find_by_id(object.user_id).try(:username)
  end


  def color
    color_to_text(object.color)
  end

  def select_color
    Note.colors.keys.map{|a| [color_to_text(a), a]}
  end

  def created_at
    format_date_time(object.created_at)
  end


  def color_to_text(color)
    case color
      when 'red'
          "Červená"
      when 'green'
          "Zelená"
      when 'yellow'
          "Žlutá"
      else
          "nedefinovaná barva"
    end
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
