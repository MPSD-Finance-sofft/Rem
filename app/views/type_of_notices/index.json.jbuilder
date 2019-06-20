json.set! :data do
  json.array! @type_of_notices do |type_of_notice|
    json.partial! 'type_of_notices/type_of_notice', type_of_notice: type_of_notice
    json.url  "
              #{link_to 'Show', type_of_notice }
              #{link_to 'Edit', edit_type_of_notice_path(type_of_notice)}
              #{link_to 'Destroy', type_of_notice, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end