class CreatePeople < ActiveRecord::Migration[5.2]
  def change
    create_table :people do |t|
      t.string :name
      t.string :last_name
      t.integer :identity_card_number
      t.integer :mobil
      t.string :personal_identification_number

      t.timestamps
    end
  end
end
