class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :search]
  def index
    @posts = Post.order(created_at: :desc)
    @tag_list = Tag.all

        #ソート検索用
    if params[:option] == "created_at_desc"
      @posts = Post.order('posts.created_at DESC')
    elsif params[:option] == "created_at_asc"
      @posts = Post.order('posts.created_at ASC')
    elsif params[:option] == "rate"
      @posts = Post.order('posts.rate DESC')
    elsif params[:option] == "shooting_date"
      @posts = Post.order('posts.shooting_date DESC')
    elsif params[:option] == "favorite"
      @posts = Post.find(Favorite.group(:post_id).order(Arel.sql('count(post_id) desc')).pluck(:post_id))
    end

  end

  def show
    if user_signed_in?
      @post = Post.find(params[:id])
      @post_comment = PostComment.new
      @post_comments = @post.post_comments.order(created_at: :desc)
      @post_tags = @post.tags
      @lat = @post.spot.latitude
      @lng = @post.spot.longitude
      gon.lat = @lat
      gon.lng = @lng
    else
      flash[:success] = "ここから先はログインが必要です！"
      redirect_to new_user_session_path
    end
  end

  def new
    @post = Post.new
    @tag_list = @post.tags.pluck(:tag_name).split(nil)
    @post.build_spot
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
        @post.save_tag(tag_list)
        flash[:success] = "写真が更新されました！"
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
    @tag_list = Tag.all               #投稿一覧表示ページでも全てのタグを表示するために、タグを全取得
    @tag = Tag.find(params[:tag_id])  #クリックしたタグを取得
    @posts = @tag.posts.all           #クリックしたタグに紐付けられた投稿を全て表示
  end
  def search
    @posts = Post.where(area: params[:area])
    @post = Post.where(area: params[:area]).first
   end

  private
    def post_params
      params.require(:post).permit(:post_image, :body, :rate, :shooting_date, :country_name, :area, spot_attributes: [:address])
    end
end