FactoryBot.define do
  sequence :email do |n|
    "user_#{n}@test.com"
  end

  factory :user do
    first_name { 'Ivan' }
    last_name { 'Ivanov' }
    admin { 'false' }
    password { '12345678' }
  end
end