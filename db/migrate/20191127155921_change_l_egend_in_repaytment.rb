class ChangeLEgendInRepaytment < ActiveRecord::Migration[5.2]
  def change
  	change_column :repaymet_types, :text, :text
  end
end
