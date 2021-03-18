FactoryBot.define do
  factory :user do
    username { Faker::Internet.username.gsub(/[^0-9A-Za-z]/, '') }
    password { Faker::Internet.password }
  end
end
