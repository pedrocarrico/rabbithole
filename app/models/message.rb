require 'bunny'

class Message < ActiveRecord::Base

  validates_length_of :body, :maximum=>160, :message=> I18n.t('activerecord.models.errors.message.body_too_long')

  belongs_to :from_user, :class_name => 'User', :foreign_key => :from_user_id
  belongs_to :to_user,   :class_name => 'User', :foreign_key => :to_user_id

  def self.publish message
    bunny = Bunny.new
    bunny.start
    exchange = bunny.exchange "rabbithole"
    exchange.publish "#{message.to_json}", :key => "message"
    bunny.stop
  end
end
