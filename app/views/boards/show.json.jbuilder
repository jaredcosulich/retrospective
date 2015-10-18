json.array!(@board.items.updated_after(@time)) do |item|
  json.extract! item, :id, :column_name, :created_at
  json.html render(partial: 'items/item', locals: {item: item}, formats: [:html])
  json.vote_html render(partial: 'items/votes_info', locals: {item: item}, formats: [:html])
  json.comment_html render(partial: 'items/comments_info', locals: {item: item}, formats: [:html]) 
end
