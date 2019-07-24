json.set! :data do
  json.array! @client_mobiles do |client_mobile|
    json.partial! 'client_mobiles/client_mobile', client_mobile: client_mobile
    json.url  "
              #{link_to 'Show', client_mobile }
              #{link_to 'Edit', edit_client_mobile_path(client_mobile)}
              #{link_to 'Destroy', client_mobile, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end