class CreateReasonRefusalTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :reason_refusal_types do |t|
      t.text :description

      t.timestamps
    end
  end
end
