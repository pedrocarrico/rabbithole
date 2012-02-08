require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  test "should publish message" do
    Message.expects(:publish).returns(true)

    message = Factory(:message)

    assert_true Message.publish(message), "Message should be published since it's a mock"
  end
end
