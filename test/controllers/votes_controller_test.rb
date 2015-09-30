require 'test_helper'

class VotesControllerTest < ActionController::TestCase
  setup do
    @board = boards(:board_one)
    @item = items(:item_one)
    @vote = votes(:vote_one)
  end

  test "should create vote" do
    assert_difference('Vote.count') do
      post :create, board_id: @board, item_id: @item, vote: { user_name: 'John Doe' }
    end
    
    assert_equal(3, User.count)
    
    assert_equal(3, @item.votes.count)
    
    vote = @item.votes.last
    
    assert_equal('John Doe', vote.user.name)

    assert_difference('Vote.count') do
      post :create, board_id: @board, item_id: @item, vote: { user_name: 'John Doe' }
    end

    assert_equal(3, User.count)
    
    assert_equal(4, @item.votes.count)
    
    vote = @item.votes.last
    
    assert_equal('John Doe', vote.user.name)

    assert_redirected_to @board
  end

  test "should destroy vote" do
    assert_difference('Vote.count', -1) do
      delete :destroy, id: @vote, board_id: @board, item_id: @item
    end

    assert_redirected_to @board
  end
end
