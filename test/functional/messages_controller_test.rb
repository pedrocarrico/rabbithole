require 'test_helper'

class MessagesControllerTest < ActionController::TestCase
  setup do
    @message = messages(:one)
  end

  test "should get index" do
    sign_in :user, users(:user)
    get :index
    assert_response :success
    assert_not_nil assigns(:messages)
  end

  test "should get new" do
    sign_in :user, users(:user)
    get :new
    assert_response :success
  end

  test "should create message" do
    sign_in :user, users(:user)
    assert_difference('Message.count') do
      post :create, message: @message.attributes
    end

    assert_redirected_to messages_path
  end

  test "should show message" do
    sign_in :user, users(:user)
    get :show, id: @message
    assert_response :success
  end

  test "should get edit" do
    sign_in :user, users(:user)
    get :edit, id: @message
    assert_response :success
  end

  test "should update message" do
    sign_in :user, users(:user)
    put :update, id: @message, message: @message.attributes
    assert_redirected_to message_path(assigns(:message))
  end

  test "should destroy message" do
    sign_in :user, users(:user)
    assert_difference('Message.count', -1) do
      delete :destroy, id: @message
    end

    assert_redirected_to messages_path
  end
end
