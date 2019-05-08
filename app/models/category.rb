class Category < ApplicationRecord
  has_ancestry
  has_many :item_categories

  require "csv"
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      category = new
      category.attributes = row.to_hash.slice(*updatable_attributes)
      category.id = row.to_hash.values[0]
      category.save!
    end
  end

  def self.updatable_attributes
    ["id","category","ancestry"]
  end

  def self.category_bread_crumbs(category)
    category_crumbs_list = {}
    if category.ancestry == nil
      category_crumbs_list = {
        parent_category: category,
        child_category:  nil,
        grandchild_category:  nil
        }
    elsif category.ancestry == "#{category.parent.id}"
      category_crumbs_list = {
        parent_category: category.parent,
        child_category: category,
        grandchild_category: nil
        }
    else
      category_crumbs_list = {
        parent_category: category.parent.parent,
        child_category: category.parent,
        grandchild_category: category
        }
    end
  end
  
end
