class UserAddCommission < ActiveRecord::Migration[5.2]
    def change
      add_column :users, :commission, :decimal
    end
  end
  