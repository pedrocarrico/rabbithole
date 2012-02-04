require 'rubygems' if RUBY_VERSION < "1.9"
require 'bunny'

bunny = Bunny.new
bunny.start
exchange = bunny.exchange "rabbithole"

queue = bunny.queue "rabbithole.messages"
queue.bind exchange, :key => "message"

puts "Subscriber listening ..."

queue.subscribe do |message|
  puts "Subscriber received: #{message[:payload].inspect}"

  new_message = JSON.parse message[:payload]

  puts new_message

  message = Message.new(new_message)
  message.save!

  puts "Message saved!"
end
