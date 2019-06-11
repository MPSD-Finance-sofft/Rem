class CreateNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|
      t.integer :accord_id
      t.integer :user_id
      t.text :description
      t.integer :color
      t.timestamps
    end
  end
end
