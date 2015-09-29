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
      post :create, board: { bad_column_name: @board.bad_column_name, close_date: @board.close_date, good_column_name: @board.good_column_name, meh_column_name: @board.meh_column_name }
    end

    assert_redirected_to board_path(assigns(:board))
  end

  test "should show board" do
    get :show, id: @board
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @board
    assert_response :success
  end

  test "should update board" do
    patch :update, id: @board, board: { bad_column_name: @board.bad_column_name, close_date: @board.close_date, good_column_name: @board.good_column_name, meh_column_name: @board.meh_column_name }
    assert_redirected_to board_path(assigns(:board))
  end

  test "should destroy board" do
    assert_difference('Board.count', -1) do
      delete :destroy, id: @board
    end

    assert_redirected_to boards_path
  end
end
