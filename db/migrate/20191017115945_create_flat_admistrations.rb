class CreateFlatAdmistrations < ActiveRecord::Migration[5.2]
  def change
    create_table :flat_admistrations do |t|
      t.string :subject
      t.string :address
      t.string :tel
      t.string :email
      t.string :note
      t.integer :accord_id

      t.timestamps
    end
  end
end
