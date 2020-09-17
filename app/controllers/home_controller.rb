class HomeController < ApplicationController
  def top
    @all_ranks = Post.find(Favorite.group(:post_id).order(Arel.sql('count(post_id) desc')).limit(10).pluck(:post_id))
    @posts = Post.search(params[:keyword])
      respond_to do |format|
        format.html
        format.json
      end
  end

  def about
  end
end
