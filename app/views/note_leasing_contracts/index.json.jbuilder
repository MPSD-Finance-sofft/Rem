json.set! :data do
  json.array! @note_leasing_contracts do |note_leasing_contract|
    json.partial! 'note_leasing_contracts/note_leasing_contract', note_leasing_contract: note_leasing_contract
    json.url  "
              #{link_to 'Show', note_leasing_contract }
              #{link_to 'Edit', edit_note_leasing_contract_path(note_leasing_contract)}
              #{link_to 'Destroy', note_leasing_contract, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end