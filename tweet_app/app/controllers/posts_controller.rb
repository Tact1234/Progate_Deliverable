class PostsController < ApplicationController
  # 事前処理
  before_action :authenticate_user
  before_action :ensure_correct_user, {only:[:edit, :update, :destroy]}

  # 投稿一覧画面
  def index
    @posts=Post.all.order(created_at: :desc)
  end

  # 新規投稿画面
  def new
    @post = Post.new
  end

  # 投稿照会画面
  def show
    @post = Post.find_by(id: params[:id])
    @like = Like.find_by(
      user_id: @current_user.id,
      post_id: params[:id]
    )
    @likes_count = Like.where(post_id: params[:id]).count
  end

  # 投稿編集画面
  def edit
    @post = Post.find_by(id: params[:id])
  end

  # 新規投稿画面
  def create
    @post = Post.new(
      content: params[:content],
      user_id: @current_user.id
    )
    if @post.save
      flash[:notice] = "投稿を作成しました"
      redirect_to("/posts/index")
    else
      render("posts/new")
    end
  end

  # 投稿編集処理
  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    if @post.save
      flash[:notice] = "投稿を編集しました"
      redirect_to("/posts/index")
    else
      render("posts/edit")
    end
  end

  # 投稿削除処理
  def destroy
    post = Post.find_by(id: params[:id])
    post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to("/posts/index")
  end

  # 投稿ユーザーチェック
  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end
end
