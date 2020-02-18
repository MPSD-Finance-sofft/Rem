class AddTrueUserIdtoActivity < ActiveRecord::Migration[5.2]
  def change
  	add_column :activities, :true_user_id, :integer
  end
end
