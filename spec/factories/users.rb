FactoryBot.define do
  sequence :user_name do |n|
    "user_#{n}"
  end

  factory :user do
    name { generate :user_name }
    email { "#{name}@example.com" }
    password { User.digest('password') }
  end
end
