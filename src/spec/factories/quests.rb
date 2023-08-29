# frozen_string_literal: true

# spec/factories/quests.rb
FactoryBot.define do
  factory :quest do
    title { 'Sample Title' }
    description { 'Sample Description' }
    category { 1 }
    status { 1 }
    difficulty { 1 }
    association :requester, factory: :user
    # acceptor の設定も必要な場合は以下の行を追加
    # association :acceptor, factory: :user
  end
end
