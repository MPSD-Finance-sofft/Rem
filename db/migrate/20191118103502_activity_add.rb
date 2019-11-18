class ActivityAdd < ActiveRecord::Migration[5.2]
  def change
  	add_column :activities, :objet, :string
  	add_column :activities, :object_id, :integer
  end
end
