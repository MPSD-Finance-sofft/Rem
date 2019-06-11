class CreateCommitmentTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :commitment_types do |t|
      t.text :description

      t.timestamps
    end
  end
end
