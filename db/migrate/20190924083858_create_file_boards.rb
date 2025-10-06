class CreateFileBoards < ActiveRecord::Migration[5.2]
  def change
    create_table :file_boards do |t|
      t.text :text
      t.integer :permission
      t.date :end
      t.date :start
      # Místo t.attachment :file použijte:
      t.string :file_file_name
      t.string :file_content_type
      t.integer :file_file_size
      t.datetime :file_updated_at
      t.timestamps
    end
  end
end
