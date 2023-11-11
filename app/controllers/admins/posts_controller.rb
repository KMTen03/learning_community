class Admins::PostsController < ApplicationController
  before_action :authenticate_admin!
  def index
    if params[:end_user_id]
      @posts = EndUser.find(params[:end_user_id]).posts.page(params[:page])
    else
      @posts = Post.page(params[:page])
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to admins_post_path(@post.id), notice: "投稿情報を変更しました。"
    else
      render :edit
    end
  end
  
  def destroy
    @posts = Post.find(params[:id])
    @posts.destroy
    redirect_to admins_posts_path, notice:"投稿が削除されました。"
  end
  
  private
  def post_params
    params.require(:post).permit(:title, :learning_time, :learning_content)
  end
end
