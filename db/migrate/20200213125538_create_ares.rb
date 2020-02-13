class CreateAres < ActiveRecord::Migration[5.2]
  def change
    create_table :ares do |t|
      t.integer :user_id
      t.string :nace
      t.string :nace_name
      t.date :date

      t.timestamps
    end
  end
end
