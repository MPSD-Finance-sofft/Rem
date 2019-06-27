json.extract! board, :id, :text, :permission, :created_at, :updated_at
json.url board_url(board, format: :json)
