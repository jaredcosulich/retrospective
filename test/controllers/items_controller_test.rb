require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  setup do
    @board = boards(:board_one)
    @item = items(:item_one)
  end


  test "should get new" do
    get :new, board_id: @board.id, column_name: 'Good'
    assert_response :success
  end

  test "should create item" do
    assert_difference('Item.count') do
      post :create, board_id: @board.id, item: { column_name: 'Good', title: 'Title', user_name: 'Janice Htims' }
    end
    
    @board.reload
    
    assert_equal(3, @board.items.length)
    
    item = @board.items.last
    
    assert_equal('Title', item.title)
    assert_equal('Good', item.column_name)
    assert_equal('Janice Htims', item.user.name)

    assert_redirected_to @board
  end

  test "should create item with a comment" do
    assert_difference('Item.count') do
      post :create, board_id: @board.id, item: { column_name: 'Good', title: 'Title', user_name: 'Janice Htims', comment: 'comment!' }
    end
    
    item = Item.last
    assert_equal(1, item.comments.count)
    
    comment = item.comments.last
    assert_equal('comment!', comment.comment)
    assert_equal(item.user, comment.user)
    assert_equal(item, comment.item)
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
    patch :update, id: @item, board_id: @board.id, item: { column_name: @item.column_name, title: @item.title, user_id: @item.user_id }
    assert_redirected_to @board
  end

  test "should destroy item" do
    assert_difference('Item.count', -1) do
      delete :destroy, id: @item, board_id: @board.id
    end

    assert_redirected_to @board
  end
end
