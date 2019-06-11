class RealtyAddAttributes < ActiveRecord::Migration[5.2]
  def change
  	 add_column :realties, :type_ownership, :integer
  	 add_column :realties, :record_on_lv, :integer
  	 add_column :realties, :price_estimation, :decimal
  	 add_column :realties, :property_sheet, :integer
  	 add_column :realties, :purchase_price, :decimal
  	 add_column :realties, :location, :integer
  	 add_column :realties, :build_up_area, :decimal
  	 add_column :realties, :land_plot, :decimal
  	 add_column :realties, :catastral_territory, :integer
  end
end
