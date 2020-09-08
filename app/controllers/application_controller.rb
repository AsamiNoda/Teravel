class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  private
  #会員新規登録時のパス
  def after_sign_up_path_for(resource)
    posts_path
  end

  #ログイン時のパス
  def after_sign_in_path_for(resource)
    if user_signed_in?
      posts_path
    else
      root_path
    end
  end

  #ログアウト時のパス
  def after_sign_out_path_for(resource)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :birthyear, :email, :profile_image])
  end
end
