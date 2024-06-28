FactoryBot.define do
  factory :user do
    name { Faker::Name.name_with_middle }
    email { Faker::Internet.email }
    password { 'password@123' }
    role { 'user' }
  end
end
