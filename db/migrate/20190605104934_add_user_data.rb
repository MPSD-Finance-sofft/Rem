class AddUserData < ActiveRecord::Migration[5.2]
  def change
  	add_column :users, :mobile, :integer
  	add_column :users, :name, :string
  	add_column :users, :last_name, :string
  	add_column :users, :name_company, :string
  	add_column :users, :identity_card_number, :string
  	add_column :users, :identity_company_number, :string
  	add_column :users, :date_of_cooperation, :date
  	add_column :users, :short_name, :string
  	add_column :users, :superior_id, :integer
  	add_column :users, :title_before, :string
  	add_column :users, :title_last, :string
  	add_column :users, :billing_address_id, :integer
  	add_column :users, :malling_address_id, :integer
  	add_column :users, :web, :string
  	add_column :users, :account_number, :integer
  	add_column :users, :bank_code, :integer
  	add_column :users, :active, :boolean
  end
end