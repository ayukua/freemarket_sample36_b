class Product < ApplicationRecord
  has_many :images, foreign_key: "item_id"
  has_many :statuses, foreign_key: "item_id"
  has_many :item_categories, foreign_key: "item_id"
  belongs_to :user
end
