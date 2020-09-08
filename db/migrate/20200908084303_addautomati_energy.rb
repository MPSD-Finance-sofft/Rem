class AddautomatiEnergy < ActiveRecord::Migration[5.2]
  def change
    add_column :accords, :automatik_add_energy, :boolean
  end
end
