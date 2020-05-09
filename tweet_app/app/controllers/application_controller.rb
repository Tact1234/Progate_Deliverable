class ApplicationController < ActionController::Base
  before_action :set_current_user

  # ログインユーザー情報取得
  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  # 非ユーザー向け機能制限
  def authenticate_user
    if @current_user == nil
      flash[:notice] = "ログインが必要です"
      redirect_to("/login")
    end
  end

  # ユーザー向け機能制限
  def borbid_login_user
    if @current_user
      flash[:notice] = "すでにログインしています。"
      redirect_to("/posts/index")
    end
  end
end
