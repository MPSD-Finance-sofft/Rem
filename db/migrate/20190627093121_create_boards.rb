class CreateBoards < ActiveRecord::Migration[5.2]
  def change
    create_table :boards do |t|
      t.text :text
      t.string :permission

      t.timestamps
    end
  end
end
