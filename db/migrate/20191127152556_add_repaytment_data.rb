class AddRepaytmentData < ActiveRecord::Migration[5.2]
  def change
  	add_column :repaymet_types, :start_date, :date
  	add_column :repaymet_types, :end_data, :date
  	add_column :repaymet_types, :cron, :boolean
  end
end
