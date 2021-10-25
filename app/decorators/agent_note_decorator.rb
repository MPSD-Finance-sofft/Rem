class AgentNoteDecorator < ApplicationDecorator
  delegate_all

  def creator
    object.creator.try(:all_name)
  end
end
