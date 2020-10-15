class PostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]

  def create
    @post = current_user.posts.build(post_params)
    
    if @post.save
      flash[:success] = '投稿しました。'
      redirect_to  controller: :categories, action: :show, id: @post.category_id
    else
      @category = Category.find(@post.category_id)
      @posts = current_user.posts.order(id: :desc).page(params[:page])
      flash[:danger] = '投稿に失敗しました。'
      flash[:warning] = @post.errors.full_messages
      render 'categories/show'
    end
  end

  def destroy
     @post.destroy
    flash[:success] = '投稿を削除しました。'
    redirect_back(fallback_location: root_path)
  end

  private

  def post_params
    params.require(:post).permit(:content, :category_id)
  end
  
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end
  end
end
