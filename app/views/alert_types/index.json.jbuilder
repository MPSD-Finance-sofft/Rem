json.set! :data do
  json.array! @alert_types do |alert_type|
    json.partial! 'alert_types/alert_type', alert_type: alert_type
    json.url  "
              #{link_to 'Show', alert_type }
              #{link_to 'Edit', edit_alert_type_path(alert_type)}
              #{link_to 'Destroy', alert_type, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end