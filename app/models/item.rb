class Item < ApplicationRecord
  has_many    :categories, through: :item_categories
  has_many    :item_categories
  belongs_to  :user
end