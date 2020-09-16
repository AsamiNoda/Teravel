class UsersController < ApplicationController
  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
		if @user.update(user_params)
			redirect_to @user
		else
			render 'edit'
		end
  end

  def show
  	@user = User.find(params[:id])
  	@posts = @user.posts

    @posts_all = Post.all

   #フォローしているユーザーを取得
    @follow_users = @user.following_user
   #フォローユーザーのツイートを表示
    @follower_posts = @posts_all.where(user_id: @follow_users).order("created_at DESC")
  end
  def follows
  end

  def followers
  end

  private
  def user_params
      params.require(:user).permit(:name, :email, :profile_image, :birthyear, :introduction)
  end
end

