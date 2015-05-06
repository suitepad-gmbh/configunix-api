FactoryGirl.define do
  factory :puppet_class do
    sequence(:name) { |n| "MyClass#{n}" }
  end

end
