class Image < ApplicationRecord
  belongs_to :product
  mount_uploader :image, ImageUploader

  def self.create_images_by(item_params)
    return false if item_params[:image].nil?

    Image.transaction do

      item_params[:image].each do |img|
        new_img = Image.new(image: item_params[:image])
        return false unless new_img.save!
      end
    end
  end
end
