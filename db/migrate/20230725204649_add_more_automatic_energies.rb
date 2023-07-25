class AddMoreAutomaticEnergies < ActiveRecord::Migration[5.2]
  def change
    add_column :accords, :automatic_electricities, :boolean
    add_column :accords, :automatic_gases, :boolean
    add_column :accords, :automatic_waters, :boolean
  end
end
