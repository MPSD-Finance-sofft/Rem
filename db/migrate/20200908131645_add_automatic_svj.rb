class AddAutomaticSvj < ActiveRecord::Migration[5.2]
  def change
    add_column :accords, :automatic_svj, :boolean
  end
end
