class AddAccordUser < ActiveRecord::Migration[5.2]
  def change
  	add_column :accords, :user_id, :integer, limit: 8
  	add_column :accords, :kind, :date
  end
end
