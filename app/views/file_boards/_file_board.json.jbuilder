json.extract! file_board, :id, :text, :permission, :end, :start, :created_at, :updated_at
json.url file_board_url(file_board, format: :json)
