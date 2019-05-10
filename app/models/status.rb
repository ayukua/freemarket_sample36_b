class Status < ApplicationRecord
  belongs_to :product, foreign_key: "item_id"
  belongs_to :user, foreign_key: "buyer_id"

  validates :stage,     presence: true
  validates :item_id,   presence: true, uniqueness: true
  validates :buyer_id,  presence: true
end
