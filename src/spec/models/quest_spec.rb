# frozen_string_literal: true

# spec/models/quest_spec.rb
require 'rails_helper'

RSpec.describe Quest, type: :model do
  it 'is valid with valid attributes' do
    requester = User.create!(email: 'test@example.com', password: 'password', password_confirmation: 'password') # 適切な属性でUserを作成
    quest = Quest.new(
      title: 'Test title',
      description: 'Test description',
      requester: requester,
      category: 1, # 適切な値を設定
      status: 1, # 適切な値を設定
      difficulty: 1 # 適切な値を設定
    )
    expect(quest).to be_valid
  end
end
