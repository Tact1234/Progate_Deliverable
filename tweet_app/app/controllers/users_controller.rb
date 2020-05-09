class UsersController < ApplicationController
  #事前処理
  before_action :authenticate_user, {only: [:index,:show,:update,:edit]}
  before_action :borbid_login_user, {only: [:login,:login_form,:new,:create]}
  before_action :ensure_correct_user, {only: [:edit,:update]}

  # ユーザー一覧画面
  def index
    @users = User.all.order(created_at: :desc)
  end

  # ユーザー照会画面
  def show
    @user = User.find_by(id: params[:id])
  end

  # ユーザー編集画面
  def edit
    @user = User.find_by(id: params[:id])
  end

  # ユーザー更新処理
  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]

    image = params[:image]
    if image
      @user.image_name = @user.id
      File.binwrite("public/user_images/#{@user.image_name}",image.read)
    end

    if @user.save
      flash[:notice] = "ユーザー情報を更新しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end
  end

  # ユーザー新規登録画面
  def new
    @user = User.new
  end

  # ユーザー新規登録処理
  def create
    @user = User.new
    @user.name = params[:name]
    @user.email = params[:email]
    @user.image_name = "default_user.jpg"
    if @user.save
      flash[:notice] = "ユーザー情報を登録しました。"
      redirect_to("/users/#{@user.id}")
    else
      render("users/new")
    end
  end

  # ログイン画面
  def login_form
  end

  # ログイン処理
  def login
    @user = User.find_by(email: params[:email],password: params[:password])
    if @user
      flash[:notice] = "ログインしました。"
      session[:user_id] = @user.id
      redirect_to("/posts/index")
    else
      @error_message = "メールアドレスまたはパスワードに誤りがあります。"
      @email = params[:email]
      @password = params[:password]
      render("users/login_form")
    end
  end

  # ログアウト処理
  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました。"
    redirect_to("/login")
  end

  # ユーザー権限判定
  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end

end
