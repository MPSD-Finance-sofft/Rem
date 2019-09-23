json.set! :data do
  json.array! @event_types do |event_type|
    json.partial! 'event_types/event_type', event_type: event_type
    json.url  "
              #{link_to 'Show', event_type }
              #{link_to 'Edit', edit_event_type_path(event_type)}
              #{link_to 'Destroy', event_type, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end