class BookmarksController < ApplicationController
before_action :set_post, only: [:create, :destroy]
  def create
    @post = Post.find(params[:post_id])
    bookmark = @post.bookmarks.new(user_id: current_user.id)
    bookmark.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    bookmark = current_user.bookmarks.find_by(post_id: @post.id)
    bookmark.destroy
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
  def set_post
    @post = Post.find(params[:post_id])
  end
end
