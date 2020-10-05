class CategoriesController < ApplicationController
 before_action :require_user_logged_in
 before_action :set_category, only: [:show]
  
  def index
    @categories = Category.all
  end

  def show
      @post = current_user.posts.build
      @posts = Post.where(category_id: params[:id]).order(created_at: :desc).page(params[:page])
  end
end

 private
 def set_category
    @category = Category.find(params[:id])
 end