# frozen_string_literal: true

# spec/factories/quests.rb
FactoryBot.define do
  factory :quest do
    title { Faker::Lorem.sentence }  # ランダムなタイトル
    description { Faker::Lorem.paragraph }  # ランダムな説明
    category { rand(1..5) }  # ランダムなカテゴリ（1から5までの整数）
    status { rand(1..3) }  # ランダムなステータス（1から3までの整数）
    difficulty { rand(1..10) }  # ランダムな難易度（1から10までの整数）
    association :requester, factory: :user

    # 追加の状態や設定のためのtrait
    trait :with_acceptor do
      association :acceptor, factory: :user
    end

    trait :high_difficulty do
      difficulty { 9 }
    end

    trait :low_difficulty do
      difficulty { 2 }
    end
  end
end
