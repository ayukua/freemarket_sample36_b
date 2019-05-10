class CategoriesController < ApplicationController

  def index
  end

  def show
    category = Category.find(params[:id])
    bread_crumbs = Category.category_bread_crumbs(category)
    @parent_category = bread_crumbs[:parent_category]
    @child_category = bread_crumbs[:child_category]
    @grandchild_category = bread_crumbs[:grandchild_category]
  end

  def new
  end

  def import
    Category.import(params[:category][:file])
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
