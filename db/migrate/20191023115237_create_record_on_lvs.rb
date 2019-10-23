class CreateRecordOnLvs < ActiveRecord::Migration[5.2]
  def change
    create_table :record_on_lvs do |t|
      t.integer :kind

      t.timestamps
    end
  end
end
