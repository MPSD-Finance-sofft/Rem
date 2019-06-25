json.set! :data do
  json.array! @mobiles do |mobile|
    json.partial! 'mobiles/mobile', mobile: mobile
    json.url  "
              #{link_to 'Show', mobile }
              #{link_to 'Edit', edit_mobile_path(mobile)}
              #{link_to 'Destroy', mobile, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end