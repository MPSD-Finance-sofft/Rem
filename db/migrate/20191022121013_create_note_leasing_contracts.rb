class CreateNoteLeasingContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :note_leasing_contracts do |t|
      t.integer :accord_id
      t.integer :user_id
      t.text :description
      t.string :color
      t.integer :permission

      t.timestamps
    end
  end
end
