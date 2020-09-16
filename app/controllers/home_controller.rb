class HomeController < ApplicationController
  def top
  @posts = Post.search(params[:keyword])
    respond_to do |format|
      format.html
      format.json
    end

    @all_ranks = Post.create_all_ranks
  end

  def about
  end
end
