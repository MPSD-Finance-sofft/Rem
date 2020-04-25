class AddPnbDateTo < ActiveRecord::Migration[5.2]
  def change
    add_column :penbs, :date_to, :date
  end
end
