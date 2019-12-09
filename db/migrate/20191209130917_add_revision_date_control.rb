class AddRevisionDateControl < ActiveRecord::Migration[5.2]
  def change
  	add_column :revisions, :datecontrol, :date
  end
end
