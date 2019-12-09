json.set! :data do
  json.array! @revision_types do |revision_type|
    json.partial! 'revision_types/revision_type', revision_type: revision_type
    json.url  "
              #{link_to 'Show', revision_type }
              #{link_to 'Edit', edit_revision_type_path(revision_type)}
              #{link_to 'Destroy', revision_type, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end