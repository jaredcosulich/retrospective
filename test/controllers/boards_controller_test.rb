require 'test_helper'

class BoardsControllerTest < ActionController::TestCase
  setup do
    @board = boards(:board_one)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create board" do
    assert_difference('Board.count') do
      post :create, board: { name: @board.name, bad_column_name: @board.bad_column_name, close_at: @board.close_at, good_column_name: @board.good_column_name, meh_column_name: @board.meh_column_name }
    end

    assert_redirected_to board_path(assigns(:board))
  end


  test "should create board for a group" do
    group = groups(:one)
    assert_difference('Board.count') do
      post :create, board: { group_id: group.id, name: @board.name, bad_column_name: @board.bad_column_name, close_at: @board.close_at, good_column_name: @board.good_column_name, meh_column_name: @board.meh_column_name }
    end
    
    assert_equal(1, group.boards.count)
    
    board = Board.last
    assert_equal(group, board.group)
    assert_equal(board, group.boards.last)
  end

  test "should show board" do
    get :show, id: @board
    assert_response :success
  end
  
  test "should show board with forms for items in each column" do
    get :show, id: @board
    assert_select "input[type=hidden][id=item_column_name][value=awesome]", {count: 1}
    assert_select "input[type=hidden][id=item_column_name][value=yucky]", {count: 1}
    assert_select "input[type=hidden][id=item_column_name][value=horrible]", {count: 1}
  end

  test "should get edit" do
    get :edit, id: @board
    assert_response :success
  end

  test "should update board" do
    patch :update, id: @board, board: { name: @board.name, bad_column_name: @board.bad_column_name, close_at: @board.close_at, good_column_name: @board.good_column_name, meh_column_name: @board.meh_column_name }
    assert_redirected_to board_path(assigns(:board))
  end

  test "should destroy board" do
    assert_difference('Board.count', -1) do
      delete :destroy, id: @board
    end

    assert_redirected_to boards_path
  end
end
