# frozen_string_literal: true

# db/seeds.rb

# ユーザー
10.times do |_n|
  User.create!(
    email: Faker::Internet.email,
    password: 'password',
    password_confirmation: 'password'
  )
end

# クエスト
20.times do
  Quest.create!(
    title: Faker::Lorem.sentence,
    description: Faker::Lorem.paragraph,
    requester_id: User.pluck(:id).sample,
    category: rand(1..5),
    status: rand(1..3),
    difficulty: rand(1..3)
  )
end
