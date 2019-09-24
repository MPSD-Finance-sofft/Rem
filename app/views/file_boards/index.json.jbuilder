json.set! :data do
  json.array! @file_boards do |file_board|
    json.partial! 'file_boards/file_board', file_board: file_board
    json.url  "
              #{link_to 'Show', file_board }
              #{link_to 'Edit', edit_file_board_path(file_board)}
              #{link_to 'Destroy', file_board, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end