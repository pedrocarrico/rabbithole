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
    message = {'from' => 'test',
               'to'   => 'test',
               'body' => 'this is a test body'
              }
    sign_in :user, Factory(:user)
    assert_difference('Message.count') do
      post :create, message: message
    end

    assert_redirected_to messages_path
    assert_equal "Message was successfully created.", flash[:notice]
  end

  test "should not create message when it's over 160 chars'" do
    message = {'from' => 'test',
               'to'   => 'test',
               'body' => 'This is a test body with over one hundred and sixty characters.This is a test body with over one hundred and sixty characters.This is a test body with over one hundred and sixty characters.'
              }
    sign_in :user, Factory(:user)

    assert_no_difference('Message.count') do
      post :create, message: message
    end

    assert_redirected_to messages_path
  end

  test "should show message" do
    message = Factory(:message)
    sign_in :user, Factory(:user)
    get :show, id: message
    assert_response :success
  end

  test "should publish message" do
    Message.expects(:publish).returns(true)

    message = Factory(:message)
    sign_in :user, Factory(:user)
    post :publish, message: message.attributes
    assert_redirected_to messages_path
  end

  test "should get edit" do
    message = Factory(:message)
    sign_in :user, Factory(:user)
    get :edit, id: message
    assert_response :success
  end

  test "should update message" do
    message = Factory(:message)
    modified_attributes = {'body' => 'this is modified test body'}
    sign_in :user, Factory(:user)
    put :update, id: message, message: modified_attributes
    message = assigns(:message)
    assert_redirected_to message_path(message)
    assert_equal modified_attributes['body'], message.body, "Message body should be #{modified_attributes['body']}"
  end

  test "should destroy message" do
    message = Factory(:message)
    sign_in :user, Factory(:user)
    assert_difference('Message.count', -1) do
      delete :destroy, id: message
    end
    assert_redirected_to messages_path
  end
end
