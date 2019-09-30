class ChangeFlatNUmberType < ActiveRecord::Migration[5.2]
  def change
  	change_column :realties, :flat_number, :string
  end
end
