class CreateAccordsRealties < ActiveRecord::Migration[5.2]
  def change
    create_table :accords_realties do |t|
      t.belongs_to :accord, foreign_key: true
      t.belongs_to :realty, foreign_key: true

      t.timestamps
    end
  end
end
