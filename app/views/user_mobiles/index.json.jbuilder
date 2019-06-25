json.set! :data do
  json.array! @user_mobiles do |user_mobile|
    json.partial! 'user_mobiles/user_mobile', user_mobile: user_mobile
    json.url  "
              #{link_to 'Show', user_mobile }
              #{link_to 'Edit', edit_user_mobile_path(user_mobile)}
              #{link_to 'Destroy', user_mobile, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end