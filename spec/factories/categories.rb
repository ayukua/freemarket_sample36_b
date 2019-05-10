FactoryBot.define do
  factory :category do
    parent_category_id      {"1"}
    child_category_id       {"11"}
    grandchild_category_id  {"301"}
  end
end
