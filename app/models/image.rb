class Image < ApplicationRecord
  belongs_to :product, optional: true, foreign_key: "item_id"
  mount_uploader :image, ImageUploader

  # def self.create_images_by(product_params)
  #   return false if product_params[:images_attributes].nil?

  #   Image.transaction do

  #     product_params[:images_attributes].each do |img|
  #       new_img = Image.new(image: img)
  #       return false unless new_img.save!
  #     end
  #   end
  # end
end
