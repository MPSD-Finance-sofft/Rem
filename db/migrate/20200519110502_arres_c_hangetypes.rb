class ArresCHangetypes < ActiveRecord::Migration[5.2]
  def change
    change_column :ares, :nace_name, :text
  end
end
