class ChangeCLient < ActiveRecord::Migration[5.2]
  def change
  	remove_column :clients, :kind
  	remove_column :clients, :object_id
  	add_column :clients, :name, :string
  	add_column :clients,:type, :string
  	add_column :clients,:identity_card_number, :string
  	add_column :clients, :personal_identification_number, :string
  	add_column :clients, :data_box, :string
  	add_column :clients, :last_name, :string
  end
end