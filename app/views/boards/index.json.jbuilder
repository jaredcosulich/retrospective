json.array!(@boards) do |board|
  json.extract! board, :id, :good_column_name, :bad_column_name, :meh_column_name, :close_date
  json.url board_url(board, format: :json)
end
