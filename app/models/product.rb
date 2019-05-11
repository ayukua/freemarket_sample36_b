class Product < ApplicationRecord
  has_many :images, foreign_key: "item_id", dependent: :delete_all
  accepts_nested_attributes_for :images, allow_destroy: true, :reject_if => :all_blank
  has_many :statuses, foreign_key: "item_id", dependent: :delete_all
  has_many :item_categories, foreign_key: "item_id"
  belongs_to :user, optional: true, foreign_key: "seller_id"
  has_many :item_categories, foreign_key: "item_id"
  scope :get_random_product, -> (id){ where("parent_category_id = ?", id).order("RAND()").limit(4) }
  validates :name, :introduce, :condition, :delivery_fee_payer, :shipping_method, :area, :days_to_delivery, :price, :seller_id, :parent_category_id, :child_category_id, :grandchild_category_id, presence: true
end
