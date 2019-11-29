class CreateAlertTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :alert_types do |t|
      t.text :description

      t.timestamps
    end
  end
end
