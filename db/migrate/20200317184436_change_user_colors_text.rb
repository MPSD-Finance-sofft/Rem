class ChangeUserColorsText < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :agent_note_text_color, :string
    add_column :users, :manager_note_text_color, :string
    add_column :users, :user_note_text_color, :string
    add_column :users, :admin_note_text_color, :string
  end
end
