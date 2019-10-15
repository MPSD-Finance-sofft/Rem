class AddAccordRepurchase < ActiveRecord::Migration[5.2]
  def change
  	add_column :accords, :repurchase, :decimal
  end
end
