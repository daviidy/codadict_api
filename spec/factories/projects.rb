FactoryBot.define do
  factory :project do
    title { Faker::Lorem.word }
    description { Faker::Lorem.paragraph }
    budget { Faker::Number.decimal(l_digits: 2) }
  end
end
