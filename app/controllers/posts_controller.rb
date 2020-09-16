class PostsController < ApplicationController
  def index
    @posts = Post.order(created_at: :desc) 
    @tag_list = Tag.all
    @posts = @posts.order(params[:change])

  end

  def show
    if user_signed_in?
      @post = Post.find(params[:id])
      @post_comment = PostComment.new
      @post_comments = @post.post_comments.order(created_at: :desc)
      @post_tags = @post.tags
    else
      flash[:success] = "ここから先はログインが必要です！"
      redirect_to new_user_session_path
    end
  end

  def new
    @post = Post.new
    @tag_list = @post.tags.pluck(:tag_name).split(nil)
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    tag_list = params[:post][:tag_name].split(nil)
      if @post.save
        @post.save_tag(tag_list)
        flash[:success] = "写真が保存されました！"
        redirect_to @post
      else
        render 'new'
      end
  end

  def edit
    @post = Post.find(params[:id])
    @tag_list = @post.tags.pluck(:tag_name).split(nil)
  end

  def update
    @post = Post.find(params[:id])
    tag_list = params[:post][:tag_name].split(nil)
      if @post.update(post_params)
        flash[:success] = "写真が更新されました！"
        @post.save_tag(tag_list)
        redirect_to @post
      else
        render 'edit'
      end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_url
  end
  def taglist
    @tag_list = Tag.all  #こっちの投稿一覧表示ページでも全てのタグを表示するために、タグを全取得
    @tag = Tag.find(params[:tag_id])  #クリックしたタグを取得
    @posts = @tag.posts.all           #クリックしたタグに紐付けられた投稿を全て表示
  end

  private
    def post_params
      params.require(:post).permit(:post_image, :body, :rate, :shooting_date, :country_name)
    end
end

