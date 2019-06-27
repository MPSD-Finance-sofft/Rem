json.set! :data do
  json.array! @boards do |board|
    json.partial! 'boards/board', board: board
    json.url  "
              #{link_to 'Show', board }
              #{link_to 'Edit', edit_board_path(board)}
              #{link_to 'Destroy', board, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end