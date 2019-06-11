class UploadAdAccord < ActiveRecord::Migration[5.2]
  def change
  	add_column :uploads, :accord_id, :integer
  end
end
