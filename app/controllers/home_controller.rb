class HomeController < ApplicationController
  def top
  @posts = Post.search(params[:keyword])
    respond_to do |format|
      format.html
      format.json
    end
  end

  def about
  end
end
