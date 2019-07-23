json.set! :data do
  json.array! @leasing_contract_clients do |leasing_contract_client|
    json.partial! 'leasing_contract_clients/leasing_contract_client', leasing_contract_client: leasing_contract_client
    json.url  "
              #{link_to 'Show', leasing_contract_client }
              #{link_to 'Edit', edit_leasing_contract_client_path(leasing_contract_client)}
              #{link_to 'Destroy', leasing_contract_client, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end