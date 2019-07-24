class AddDataToClient < ActiveRecord::Migration[5.2]
  def change
  	add_column :people, :email, :string
  	add_column :people, :marital_status, :integer
  	remove_column :people, :mobile
  end
end
