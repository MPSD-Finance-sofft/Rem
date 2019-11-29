class AddBoardToDate < ActiveRecord::Migration[5.2]
  def change
  	add_column :boards, :end_date, :date
  end
end
