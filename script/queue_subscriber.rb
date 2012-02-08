require 'rubygems' if RUBY_VERSION < "1.9"
require 'bunny'

bunny = Bunny.new
bunny.start
exchange = bunny.exchange "rabbithole"

queue = bunny.queue "rabbithole.messages" , :durable => true
queue.bind exchange, :key => "message"

Rails.logger.info 'Subscriber listening ...'

queue.subscribe do |message|
  Rails.logger.info "Subscriber received: #{message[:payload].inspect}"

  new_message = JSON.parse message[:payload]

  Rails.logger.debug "Got message: #{new_message}"

  message = Message.new(new_message)
  message.save!

  Rails.logger.info "Message delivered"
end
