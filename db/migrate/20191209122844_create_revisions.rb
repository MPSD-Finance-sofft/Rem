class CreateRevisions < ActiveRecord::Migration[5.2]
  def change
    create_table :revisions do |t|
      t.integer :revision_type_id
      t.date :delivery_report
      t.date :valididity_from_report
      t.date :expiration_report
      t.decimal :amount
      t.integer :realty_id
      t.integer :user_id

      t.timestamps
    end
  end
end
