json.set! :data do
  json.array! @cooperations do |cooperation|
    json.partial! 'cooperations/cooperation', cooperation: cooperation
    json.url  "
              #{link_to 'Show', cooperation }
              #{link_to 'Edit', edit_cooperation_path(cooperation)}
              #{link_to 'Destroy', cooperation, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end