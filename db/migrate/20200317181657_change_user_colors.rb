class ChangeUserColors < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :agent_note_color, :string
    add_column :users, :manager_note_color, :string
    add_column :users, :user_note_color, :string
    add_column :users, :admin_note_color, :string
  end
end
