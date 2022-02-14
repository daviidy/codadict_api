FactoryBot.define do
  factory :proposal do
    price { Faker::Number.decimal(l_digits: 2) }
    deadline { Faker::Date.between(from: '2021-09-23', to: '2025-09-25') }
    project_id nil
  end
end