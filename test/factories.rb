FactoryGirl.define do
  factory :user do |u|
    u.sequence(:email)  {|s| "test#{s}@rabbit.hole.net"}
    u.password 'testing'
  end
  
  factory :message do |m|
    m.association :from_user, :factory => :user
    m.association :to_user,   :factory => :user
    m.body 'this is a test message'
  end
end