require 'csv'
namespace :import_user do
  task :import => :environment do
  	convert = {"Datum platby" => 'date_payment', 'Hradí' => 'kind', 'Částka' => 'amount'}
  	CSV.foreach(file.path, headers: true, header_converters: lambda { |name| convert[name] }) do |row|
			r = User.new row.to_hash
			r.save!
		end
  end
end