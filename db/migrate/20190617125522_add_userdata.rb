class AddUserdata < ActiveRecord::Migration[5.2]
  def change
  	    add_column :users, :can_sign_in, :boolean
    	add_column :users, :complate_documentation, :boolean
  end
end
