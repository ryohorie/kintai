FactoryBot.define do
  factory :user do
    name 'user'
    email 'user@example.com'
    password { User.digest('password') }

    factory :user_with_empty_name do
      name nil
    end

    factory :user_with_blank_name do
      name '     '
    end

    factory :user_with_too_long_name do
      name 'a' * 51
    end

    factory :user_with_empty_email do
      email nil
    end

    factory :user_with_blank_email do
      email '     '
    end

    factory :user_with_too_long_email do
      email 'a' * 244 + '@example.com'
    end

    factory :user_with_empty_password do
      password nil
    end
  end
end
