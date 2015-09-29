require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  setup do
    @board = boards(:board_one)
    @item = items(:item_one)
    @comment = comments(:comment_one)
  end

  test "should get index" do
    get :index, board_id: @board.id, item_id: @item.id
    assert_response :success
    assert_not_nil assigns(:comments)
  end

  test "should get new" do
    get :new, board_id: @board.id, item_id: @item.id
    assert_response :success
  end

  test "should create comment" do
    assert_difference('Comment.count') do
      post :create, board_id: @board.id, item_id: @item.id, comment: { comment: @comment.comment, user_id: @comment.user_id }
    end

    assert_redirected_to comment_path(assigns(:comment))
  end

  test "should show comment" do
    get :show, id: @comment, board_id: @board.id, item_id: @item.id
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @comment, board_id: @board.id, item_id: @item.id
    assert_response :success
  end

  test "should update comment" do
    patch :update, board_id: @board.id, id: @comment, comment: { comment: @comment.comment, item_id: @comment.item_id, user_id: @comment.user_id }
    assert_redirected_to comment_path(assigns(:comment))
  end

  test "should destroy comment" do
    assert_difference('Comment.count', -1) do
      delete :destroy, board_id: @board.id, item_id: @item.id, id: @comment
    end

    assert_redirected_to @board
  end
end
