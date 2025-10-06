# db/migrate/20190319150830_add_attachmet_to_uploads.rb
class AddAttachmetToUploads < ActiveRecord::Migration[5.2]
  def self.up
    # Nejdříve vytvořte tabulku, pokud neexistuje
    create_table :uploads, if_not_exists: true do |t|
      t.timestamps
    end
    
    # Pak přidejte sloupce
    change_table :uploads do |t|
      t.string :file_file_name
      t.string :file_content_type
      t.integer :file_file_size
      t.datetime :file_updated_at
    end
  end

  def self.down
    change_table :uploads do |t|
      t.remove :file_file_name
      t.remove :file_content_type
      t.remove :file_file_size
      t.remove :file_updated_at
    end
  end
end
