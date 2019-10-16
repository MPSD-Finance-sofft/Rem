class AccordAddDateMeetinInTerain < ActiveRecord::Migration[5.2]
  def change
  	add_column :accords, :date_meeting_in_terain, :date
  end
end
