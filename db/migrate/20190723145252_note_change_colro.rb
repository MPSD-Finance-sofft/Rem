class NoteChangeColro < ActiveRecord::Migration[5.2]
  def change
  	change_column :notes, :color, :string
  end
end
