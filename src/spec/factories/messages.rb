# frozen_string_literal: true

FactoryBot.define do
  factory :message do
    content { 'MyText' }
    quest { nil }
    sender { nil }
    receiver { nil }
  end
end
