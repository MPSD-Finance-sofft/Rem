class CreateRealties < ActiveRecord::Migration[5.2]
  def change
    create_table :realties do |t|
      t.belongs_to :realty_type, foreign_key: true

      t.timestamps
    end
  end
end
