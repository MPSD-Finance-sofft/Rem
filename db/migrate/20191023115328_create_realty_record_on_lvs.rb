class CreateRealtyRecordOnLvs < ActiveRecord::Migration[5.2]
  def change
    create_table :realty_record_on_lvs do |t|
      t.integer :realty_id
      t.integer :record_on_lv_id

      t.timestamps
    end
  end
end
