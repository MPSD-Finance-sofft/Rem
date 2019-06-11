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
end
