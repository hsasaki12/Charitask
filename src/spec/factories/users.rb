# frozen_string_literal: true

# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    # username { Faker::Internet.username }
    # usernameが必要なければこの行を削除
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
