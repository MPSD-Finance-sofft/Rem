json.set! :data do
  json.array! @leasing_contracts do |leasing_contract|
    json.partial! 'leasing_contracts/leasing_contract', leasing_contract: leasing_contract
    json.url  "
              #{link_to 'Show', leasing_contract }
              #{link_to 'Edit', edit_leasing_contract_path(leasing_contract)}
              #{link_to 'Destroy', leasing_contract, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end