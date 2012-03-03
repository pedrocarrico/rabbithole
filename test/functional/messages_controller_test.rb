require 'test_helper'

class MessagesControllerTest < ActionController::TestCase
  test "should get index" do
    sign_in :user, Factory(:user)
    get :index
    assert_response :success
    assert_not_nil assigns(:messages)
  end

  test "should get new" do
    sign_in :user, Factory(:user)
    get :new
    assert_response :success
  end

  test "should create message" do
    user = Factory(:user)
    message = {'from_user_id' => user.id,
               'to_user_id'   => user.id,
               'body' => 'this is a test body'
              }
    sign_in :user, user
    assert_difference('Message.count') do
      post :create, message: message
    end

    assert_redirected_to messages_path
    assert_equal "Message was successfully created.", flash[:notice]
  end

  test "should not create message when it's over 160 chars'" do
    user = Factory(:user)
    message = {'from_user_id' => user.id,
               'to_user_id'   => user.id,
               'body' => 'This is a test body with over one hundred and sixty characters.This is a test body with over one hundred and sixty characters.This is a test body with over one hundred and sixty characters.'
              }
    sign_in :user, user

    assert_no_difference('Message.count') do
      post :create, message: message
    end

    assert_redirected_to messages_path
  end

  test "should show message" do
    user = Factory(:user)
    message = Factory(:message, :from_user => user)
    sign_in :user, user
    get :show, id: message
    assert_response :success
  end

  test "should publish message" do
    Message.expects(:publish).returns(true)

    user = Factory(:user)
    message = Factory(:message, :from_user => user)
    sign_in :user, user
    post :publish, message: message.attributes
    assert_redirected_to messages_path
  end

  test "should get edit" do
    user = Factory(:user)
    message = Factory(:message, :from_user => user)
    sign_in :user, user
    get :edit, id: message
    assert_response :success
  end

  test "should update message" do
    user = Factory(:user)
    message = Factory(:message, :from_user => user)
    modified_attributes = {'body' => 'this is modified test body'}
    sign_in :user, user
    put :update, id: message, message: modified_attributes
    message = assigns(:message)
    assert_redirected_to message_path(message)
    assert_equal modified_attributes['body'], message.body, "Message body should be #{modified_attributes['body']}"
  end

  test "should destroy message" do
    user = Factory(:user)
    message = Factory(:message, :from_user => user)
    sign_in :user, user
    assert_difference('Message.count', -1) do
      delete :destroy, id: message
    end
    assert_redirected_to messages_path
  end
end
