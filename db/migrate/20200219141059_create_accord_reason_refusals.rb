class CreateAccordReasonRefusals < ActiveRecord::Migration[5.2]
  def change
    create_table :accord_reason_refusals do |t|
      t.integer :accord_id
      t.integer :reason_refusal_type_id
      t.integer :user_id

      t.timestamps
    end
  end
end
