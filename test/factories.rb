FactoryGirl.define do
  factory :user do |u|
    u.email 'test@rabbit.hole.net'
    u.password 'testing'
  end
  
  factory :message do |m|
    m.from 'test'
    m.to   'test'
    m.body 'this is a test message'
  end
end