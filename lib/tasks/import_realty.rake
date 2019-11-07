require 'csv'
namespace :import_realty do
  task :import => :environment do
  	file = File.open Rails.root.join('tmp', 'nemovitosti.csv')
  	convert = {
  			"zadost_id" => 'accord_id',
  			"zastavena_plocha" => 'build_up_area',
  			"plocha_zahrady" => 'land_plot',
  			"typ" => 'realty_type',
  			"typ_vlastnictvi" => 'type_ownership',
  			"zaznam_na_lv" => 'nil',
  			"odhad_trzni_ceny" => 'price_estimation',
  			"vykupni_cena" => 'purchase_price',
  			"lokalita" => 'location',
  			"list_vlastnictvi" => 'property_sheet',
  			"dispozice" => 'disposition_id',
  			"cislo_bytove_jednotky" => 'flat_number',
  			"spoluvlastnicky_podil" => 'part_number',
  			"realny_pocet_nadzemnich_podlazi" => 'real_number_abovegroud_floors',
  			"kat_uzemi" => 'catastral_territory',
  			"ulice" => 'street',
  			"cislo" => 'number',
  			"obec" => 'village',
  			"psc" => 'zip',
  			"okres" => 'district',
  			"kraj" => 'region',
  			"type" => 'record_on_lv',}
  	CSV.foreach(file.path, headers: true, header_converters: lambda { |name| convert[name] }) do |row|
  			h = row.to_hash
  			h.delete('nil')
  			h.delete(nil)
  			typ = h.delete('realty_type')
  			dispozice = h.delete('disposition_id')
        accord_id = h.delete('accord_id')
  			acord = Accord.find_by_number accord_id
      unless acord.blank?
  	     h.delete('type')
  			address = Address.new
  			address.street = h.delete('street')
    			address.village = h.delete('village')
    			address.number = h.delete('number')
    			address.zip = h.delete('zip')
    			address.district = h.delete('district')
    			address.region = h.delete('region')
  			r = acord.realty.build(h)
        r.realty_type_id = RealtyType.find_by_name(typ).try(:id)
        r.disposition_id = Disposition.find_by_name(dispozice).try(:id)
  			acord.save(validate:false)
        r.save(validate:false)
        ar = AccordsRealty.new(accord_id:acord.id, realty_id: r.id)
        ar.save(validate:false)
        r.address= address
    		r.save(validate: false)
      end
		end
  end
end