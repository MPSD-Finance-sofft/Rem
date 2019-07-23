class AddPermmisionToNote < ActiveRecord::Migration[5.2]
  def change
	add_column :notes, :permission, :integer
  	add_column :uploads, :permission, :integer
  end
end
