class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :village
      t.string :zip
      t.string :district
      t.string :region
      t.string :number

      t.timestamps
    end
  end
end
