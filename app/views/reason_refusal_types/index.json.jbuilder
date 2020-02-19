json.set! :data do
  json.array! @reason_refusal_types do |reason_refusal_type|
    json.partial! 'reason_refusal_types/reason_refusal_type', reason_refusal_type: reason_refusal_type
    json.url  "
              #{link_to 'Show', reason_refusal_type }
              #{link_to 'Edit', edit_reason_refusal_type_path(reason_refusal_type)}
              #{link_to 'Destroy', reason_refusal_type, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end