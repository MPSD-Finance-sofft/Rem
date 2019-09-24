class CreateFileBoards < ActiveRecord::Migration[5.2]
  def change
    create_table :file_boards do |t|
      t.text :text
      t.integer :permission
      t.date :end
      t.date :start
      t.attachment :file
      t.timestamps
    end
  end
end
