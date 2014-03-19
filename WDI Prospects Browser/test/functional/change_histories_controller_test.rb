require 'test_helper'

class ChangeHistoriesControllerTest < ActionController::TestCase
  setup do
    @change_history = change_histories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:change_histories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create change_history" do
    assert_difference('ChangeHistory.count') do
      post :create, change_history: { change: @change_history.change, email: @change_history.email, username: @change_history.username }
    end

    assert_redirected_to change_history_path(assigns(:change_history))
  end

  test "should show change_history" do
    get :show, id: @change_history
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @change_history
    assert_response :success
  end

  test "should update change_history" do
    put :update, id: @change_history, change_history: { change: @change_history.change, email: @change_history.email, username: @change_history.username }
    assert_redirected_to change_history_path(assigns(:change_history))
  end

  test "should destroy change_history" do
    assert_difference('ChangeHistory.count', -1) do
      delete :destroy, id: @change_history
    end

    assert_redirected_to change_histories_path
  end
end
