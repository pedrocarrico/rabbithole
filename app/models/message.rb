require 'bunny'

class Message < ActiveRecord::Base
  def self.publish message
    bunny = Bunny.new
    bunny.start
    exchange = bunny.exchange "rabbithole"
    exchange.publish "#{message.to_json}", :key => "message"
    bunny.stop
  end
end
