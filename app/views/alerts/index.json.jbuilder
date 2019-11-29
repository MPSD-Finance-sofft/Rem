json.set! :data do
  json.array! @alerts do |alert|
    json.partial! 'alerts/alert', alert: alert
    json.url  "
              #{link_to 'Show', alert }
              #{link_to 'Edit', edit_alert_path(alert)}
              #{link_to 'Destroy', alert, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end