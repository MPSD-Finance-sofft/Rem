class CreateAccords < ActiveRecord::Migration[5.2]
  def change
    create_table :accords do |t|
      t.integer :state
      t.string :type

      t.timestamps
    end
  end
end
