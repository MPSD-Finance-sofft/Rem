class AddBoardDate < ActiveRecord::Migration[5.2]
  def change
  	add_column :boards, :date, :date
  end
end
