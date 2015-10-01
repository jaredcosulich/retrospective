require 'test_helper'

class GroupsControllerTest < ActionController::TestCase
  setup do
    @group = groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create group" do
    parent_group = groups(:two)
    assert_difference('Group.count') do
      post :create, group: { description: @group.description, parent_group_id: parent_group.id, title: @group.title }
    end
    
    group = Group.last
    assert_equal(group, parent_group.children.last)

    assert_redirected_to group_path(assigns(:group))
  end

  test "should create a parent group" do
    child_group = groups(:two)
    assert_difference('Group.count') do
      post :create, group: { description: @group.description, child_group_id: child_group.id, title: @group.title }
    end

    group = Group.last
    child_group.reload
    assert_equal(group, child_group.parent_group)

    assert_redirected_to group_path(assigns(:group))
  end

  test "should create a child group" do
    assert_difference('Group.count') do
      post :create, group: { description: @group.description, parent_group_id: @group.parent_group_id, title: @group.title }
    end

    assert_redirected_to group_path(assigns(:group))
  end

  test "should show group" do
    get :show, id: @group
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @group
    assert_response :success
  end

  test "should update group" do
    patch :update, id: @group, group: { description: @group.description, parent_group_id: @group.parent_group_id, title: @group.title }
    assert_redirected_to group_path(assigns(:group))
  end

  test "should destroy group" do
    assert_difference('Group.count', -1) do
      delete :destroy, id: @group
    end

    assert_redirected_to groups_path
  end
end
