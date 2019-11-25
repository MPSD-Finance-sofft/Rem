json.set! :data do
  json.array! @repaymet_types do |repaymet_type|
    json.partial! 'repaymet_types/repaymet_type', repaymet_type: repaymet_type
    json.url  "
              #{link_to 'Show', repaymet_type }
              #{link_to 'Edit', edit_repaymet_type_path(repaymet_type)}
              #{link_to 'Destroy', repaymet_type, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end