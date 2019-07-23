json.set! :data do
  json.array! @dispositions do |disposition|
    json.partial! 'dispositions/disposition', disposition: disposition
    json.url  "
              #{link_to 'Show', disposition }
              #{link_to 'Edit', edit_disposition_path(disposition)}
              #{link_to 'Destroy', disposition, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end