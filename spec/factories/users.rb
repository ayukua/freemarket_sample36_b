FactoryBot.define do
  factory :user do
    password = Faker::Internet.password(8)
    first_name = Faker::Name.first_name
    family_name = Faker::Name.last_name
    id                    {Faker::Number.number(3)}
    nickname              {Faker::Name.name}
    email                 {Faker::Internet.email}
    password              {password}
    password_confirmation {password}
    family_name           {family_name}
    first_name            {first_name}
    kana_family_name      {family_name}
    kana_first_name       {first_name}
    birth_year            {Faker::Number.between(2, 131)}
    birth_month           {Faker::Number.between(2, 13)}
    birth_day             {Faker::Number.between(2, 32)}
    postal_code           {Faker::Address.postcode}
    prefecture            {Faker::Address.community}
    city                  {Faker::Address.city}
    block_number          {Faker::Address.building_number}
  end

end
