class AutocompleterAddressController < ApplicationController
	def cislo_kat_uzemi_find
    	render json: AutocompleterAddress::find_cislo_kat_uzemi(params[:term])
  	end

	def cislo_parcely_find
		render json: AutocompleterAddress::find_cislo_parcely(params[:request][:term],params[:before])
	end

	def obec_find
		render json: AutocompleterAddress::find_obec(params[:term]), :root => false
	end

	def ulice_find
		render json: AutocompleterAddress::find_ulice(params[:request][:term],params[:before_obec]), :root => false
	end

	def cislo_find
		render json: AutocompleterAddress::cislo_find(params[:request][:term],params[:before_obec],params[:before_ulice]), :root => false
	end

	def validate_adresa
		render json: AutocompleterAddress::validate_adres(params[:before_obec], params[:before_ulice], params[:before_cislo])
	end
end