require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  setup do
    @board = boards(:board_one)
    @item = items(:item_one)
  end


  test "should get new" do
    get :new, board_id: @board.id
    assert_response :success
  end

  test "should create item" do
    assert_difference('Item.count') do
      post :create, board_id: @board.id, item: { column_name: @item.column_name, description: @item.description, user_id: @item.user_id }
    end

    assert_redirected_to @board
  end

  test "should show item" do
    get :show, id: @item, board_id: @board.id
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @item, board_id: @board.id
    assert_response :success
  end

  test "should update item" do
    patch :update, id: @item, board_id: @board.id, item: { column_name: @item.column_name, description: @item.description, user_id: @item.user_id }
    assert_redirected_to @board
  end

  test "should destroy item" do
    assert_difference('Item.count', -1) do
      delete :destroy, id: @item, board_id: @board.id
    end

    assert_redirected_to @board
  end
end
