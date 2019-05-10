FactoryBot.define do
  factory :product do
    name                    {Faker::Beer.name}
    introduce               {Faker::Lorem.paragraphs}
    condition               {Faker::Number.between(1, 6)}
    delivery_fee_payer      {Faker::Number.between(1, 2)}
    shipping_method         {Faker::Number.between(1, 9)}
    area                    {Faker::Number.between(1, 48)}
    days_to_delivery        {Faker::Number.between(1, 3)}
    price                   {Faker::Number.between(300, 100000)}
    parent_category_id      {"1"}
    child_category_id       {"11"}
    grandchild_category_id  {"301"}
  end
end
