json.array!(@board.items) do |item|
  json.extract! item, :id
  json.vote_count item.votes.count
  json.comments_count item.comments.count  
end
