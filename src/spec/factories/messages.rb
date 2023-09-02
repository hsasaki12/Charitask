FactoryBot.define do
  factory :message do
    content { "MyText" }
    quest { nil }
    sender { nil }
    receiver { nil }
  end
end
