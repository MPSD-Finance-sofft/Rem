class AutocompleterAddress
#************************************** Parcely ************************************************************
   def self.find_cislo_kat_uzemi(value)
     uri = URI('http://adresy2.sitd.cz:80/naseptavac.json')
     http = Net::HTTP.new(uri.host, uri.port)
     http.use_ssl = false
     request = Net::HTTP::Get.new(uri.path, {'Content-Type' => 'application/json'})
     request.body = {value: value, typ_volani: 1, pocet_vysledku: 10}.to_json

     response = http.request(request)
     JSON.parse(response.body).map{|a| a['kod_katastralniho_uzemi'].to_s}
   end

   def self.find_cislo_parcely(value,before)
     uri = URI('http://adresy2.sitd.cz:80/naseptavac.json')
     http = Net::HTTP.new(uri.host, uri.port)
     http.use_ssl = false
     request = Net::HTTP::Get.new(uri.path, {'Content-Type' => 'application/json'})
     request.body = {value: value, typ_volani: 2, pocet_vysledku: 10, predchozi_id: before}.to_json
     response = http.request(request)
     JSON.parse(response.body).map{|a| "#{a['kmenove_cislo']}#{uprava_podeleni(a['poddeleni_cisla'])}" }
   end

   def self.find_id_parcely(value,before)
     uri = URI('http://adresy2.sitd.cz:80/naseptavac.json')
     http = Net::HTTP.new(uri.host, uri.port)
     http.use_ssl = false
     request = Net::HTTP::Get.new(uri.path, {'Content-Type' => 'application/json'})
     request.body = {value: value, typ_volani: 2, pocet_vysledku: 10, predchozi_id: before}.to_json
     response = http.request(request)
     value_split = value.split('/')
     value_split << nil if value_split.count != 2
     response_body = JSON.parse(response.body)
     response_body.select{|b| (b['kmenove_cislo'] == value_split.first.to_i) && (b['poddeleni_cisla'].to_i == value_split.last.to_i)}.first['id_parcely'] unless response_body.blank?
   end

   #**********************************************Adresy ******************************************************

   def self.obec(value)
     uri = URI('http://adresy2.sitd.cz/autocompleter.json')
     http = Net::HTTP.new(uri.host, uri.port)
     http.use_ssl = false
     request = Net::HTTP::Get.new(uri.path, {'Content-Type' => 'application/json'})
     request.body = {value: value, pocet_vysledku: 20, typ_volani: 1 ,min_chars: 1}.to_json
     response = http.request(request)
     binding.pry
     JSON.parse(response.body)
   end

   def self.find_obec(value)
     # self.obec(value).map{|a| "#{a['nazev_obce'].to_s}, #{a['nazev_casti_obce'].to_s} [#{a['nazev_okresu'].to_s}]"}.uniq
     self.obec(value).uniq
     # self.obec(value).map{|a| "#{a['nazev_obce'].to_s}"}.uniq
   end

   def self.ulice(value,before)
      # kod = self.obec(before).first['kod_obce']
      uri = URI('http://adresy2.sitd.cz/autocompleter.json')
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = false
      request = Net::HTTP::Get.new(uri.path, {'Content-Type' => 'application/json'})
      request.body = {value: value, pocet_vysledku: 20, typ_volani: 2 ,min_chars: 1,predchozi_id: before}.to_json
      response = http.request(request)
      JSON.parse(response.body)
   end

   def self.find_ulice(value,before)
     self.ulice(value,before).map{|a| "#{a['nazev_ulice'].to_s}"}
   end

   def self.cislo_find(value,obec,ulice_nazev)
     if ulice_nazev.present?
       ulice = self.ulice(ulice_nazev, obec['kod_obce']).first
       kod = ulice['kod_ulice']
       typ_volani = 4
     else
       # kod = self.obec(before_obec).map{|o| o['kod_casti_obce']}.compact
       kod = obec['kod_casti_obce']
       typ_volani = 5
     end
     uri = URI('http://adresy2.sitd.cz/autocompleter.json')
     http = Net::HTTP.new(uri.host, uri.port)
     http.use_ssl = false
     request = Net::HTTP::Get.new(uri.path, {'Content-Type' => 'application/json'})
     request.body = {value: value, pocet_vysledku: 20, typ_volani: typ_volani ,min_chars: 1,predchozi_id: kod}.to_json
     response = http.request(request)
     JSON.parse(response.body).map{|a| a['cislo_orientacni'].present? ? "#{a['cislo_orientacni'].to_s} / #{a['cislo_popisne'].to_s}" : a['cislo_popisne'].to_s}
   end


   def self.validate_adres(obec,ulice_nazev, cislo_popisne)
     uri = URI('http://adresy2.sitd.cz/adresy/-1.json')
     http = Net::HTTP.new(uri.host, uri.port)
     http.use_ssl = false
     request = Net::HTTP::Get.new(uri.path, {'Content-Type' => 'application/json'})
     if ulice_nazev.present?
       request.body = {adresa: {obec: obec['nazev_obce'], ulice: ulice_nazev, cislo_popisne: cislo_popisne}}.to_json
     else
       request.body = {adresa: {obec: obec['nazev_obce'], cast_obce: obec['nazev_casti_obce'], cislo_popisne: cislo_popisne.gsub(' ', ''), psc: obec['psc']}}.to_json
     end
     response = http.request(request)
     return JSON.parse(response.body)['adresa'] unless response.body.nil?
   end

   def self.adresa_podle_kodu(kod)
     uri = URI("http://adresy2.sitd.cz/adresy/#{kod}.json")
     http = Net::HTTP.new(uri.host, uri.port)
     http.use_ssl = false
     request = Net::HTTP::Get.new(uri.path, {'Content-Type' => 'application/json'})
     response = http.request(request)
     return JSON.parse(response.body)['adresa'] unless response.body.nil?
   end

   def self.najdi_adresu_podle_naseptavace(adresa)
   adresa_help = AutocompleterAdres::validate_adres(adresa.obec,adresa.ulice,adresa.cislo)
   # adresa_help.ulice = adresa_help.obec if adresa_help.ulice.blank?
     unless adresa_help.blank?
       ws_id_adresy = adresa_help['kod_adresy'] unless adresa_help.blank?
       return adresa if ws_id_adresy == -1
       adresa_v_eszusu = Adresa.find_by_ws_id ws_id_adresy
       return adresa_v_eszusu unless adresa_v_eszusu.blank?
       nova_adresa = Adresa.new(adresa_help.except('kod_adresy','cislo_popisne','kod_ulice','kod_casti_obce','kod_obce','errors', 'cislo_orientacni'))
       nova_adresa.ws_id = ws_id_adresy
       nova_adresa.cislo = adresa_help['cislo_orientacni'].blank? ? adresa_help['cislo_popisne'] : "#{adresa_help['cislo_popisne']} / #{adresa_help['cislo_orientacni']}"
       nova_adresa.save
       nova_adresa
     end
   end

   def self.najdi_adresu_podle_kodu_adresy(kod_adresy)
     return if kod_adresy.blank?
     adresa_help = AutocompleterAdres::adresa_podle_kodu kod_adresy
     unless adresa_help.blank?
       ws_id_adresy = adresa_help['kod_adresy'] unless adresa_help.blank?
       # return if ws_id_adresy.present? #co to?
       adresa_v_eszusu = Adresa.find_by_ws_id ws_id_adresy
       return adresa_v_eszusu unless adresa_v_eszusu.blank?
       nova_adresa = Adresa.new(adresa_help.except('kod_adresy','cislo_popisne','kod_ulice','kod_casti_obce','kod_obce','errors', 'cislo_orientacni'))
       nova_adresa.ws_id = ws_id_adresy
       nova_adresa.obec_ws_id = adresa_help['kod_obce']
       nova_adresa.cislo = adresa_help['cislo_orientacni'].blank? ? adresa_help['cislo_popisne'] : "#{adresa_help['cislo_popisne']} / #{adresa_help['cislo_orientacni']}"
       nova_adresa.ulice = nova_adresa.obec if nova_adresa.ulice.blank?
       nova_adresa.save
       nova_adresa
     end
   end

   def self.uprava_podeleni(text)
     ('/' + text.to_s) unless text.blank?
   end


end
