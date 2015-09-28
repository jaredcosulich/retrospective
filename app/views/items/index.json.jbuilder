json.array!(@items) do |item|
  json.extract! item, :id, :description, :column_name, :board_id, :user_id
  json.url item_url(item, format: :json)
end
