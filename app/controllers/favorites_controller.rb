class FavoritesController < ApplicationController
  before_action :set_post
  def create
    @post = Post.find(params[:post_id])
    favorite = @post.favorites.new(user_id: current_user.id)
    favorite.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: @post.id)
    favorite.destroy
  end

  private
  def redirect
    case params[:redirect_id].to_i
    when 0
      redirect_to posts_path
    when 1
      redirect_to post_path(@post)
    end
  end
  private
  def set_post
    @post = Post.find(params[:post_id])
  end
end
