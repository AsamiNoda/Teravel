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

