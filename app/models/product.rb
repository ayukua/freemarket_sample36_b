class Product < ApplicationRecord
  has_many :images, foreign_key: "item_id"
  has_many :statuses, foreign_key: "item_id"
  has_many :item_categories, foreign_key: "item_id"
  belongs_to :user, optional: true
  accepts_nested_attributes_for :images, allow_destroy: true, :reject_if => :all_blank
end
