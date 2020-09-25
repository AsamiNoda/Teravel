class HomeController < ApplicationController
  def top
    @all_ranks = Post.find(Favorite.group(:post_id).order(Arel.sql('count(post_id) desc')).limit(10).pluck(:post_id))

    return nil if params[:keyword] == ""
    @tags = Tag.search(params[:keyword])
      respond_to do |format|
        format.html
        format.json
      end


    @post = Post.where(area: "Europe")
  end

  def about
  end
end
