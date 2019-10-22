class TerrainDecorator < ApplicationDecorator
  delegate_all

  def date_to_terrain
  	format_date object.date_to_terrain
  end

  def date_meeting_in_terain
  	format_date object.date_meeting_in_terain
  end

  def agent
  	object.agent.try(:all_name)
  end

  def user
  	object.user.try(:all_name)
  end

  def date_end_terrain
  	format_date object.date_end_terrain
  end

  def object_agent_id
    object.agent_id
  end
  
end
