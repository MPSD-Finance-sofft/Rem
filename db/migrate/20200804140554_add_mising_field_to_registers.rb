class AddMisingFieldToRegisters < ActiveRecord::Migration[5.2]
  def change
    add_column :registers, :warrant_electronic, :boolean
    add_column :registers, :warrant_paper, :boolean
    add_column :registers, :user_id, :integer
  end
end
