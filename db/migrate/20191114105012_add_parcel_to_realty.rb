class AddParcelToRealty < ActiveRecord::Migration[5.2]
  def change
  	add_column :realties, :parcel_number, :string
  end
end
