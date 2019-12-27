FactoryBot.define do
  factory :user do
    username {"userA"}
    email {"userA@example.com"}
    password {"password1"}
    password_confirmation {"password1"}
  end

  factory :user_b do
    username {"userB"}
    email {"userB@example.com"}
    password {"password1"}
    password_confirmation {"password1"}
  end

  factory :admin_user do
    username {"admin"}
    email {"admin@example.com"}
    password {"password2"}
    password_confirmation {"password2"}
    admin {true}
  end

end
