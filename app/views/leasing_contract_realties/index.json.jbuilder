json.set! :data do
  json.array! @leasing_contract_realties do |leasing_contract_realty|
    json.partial! 'leasing_contract_realties/leasing_contract_realty', leasing_contract_realty: leasing_contract_realty
    json.url  "
              #{link_to 'Show', leasing_contract_realty }
              #{link_to 'Edit', edit_leasing_contract_realty_path(leasing_contract_realty)}
              #{link_to 'Destroy', leasing_contract_realty, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end