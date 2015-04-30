FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| 'email%03d@example.com'%[n] }
    password 'secret password'
  end

end
