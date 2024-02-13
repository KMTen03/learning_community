class Publics::PostsController < ApplicationController
  before_action :authenticate_end_user!

  def index
    @post = Post.new
    @end_user = current_end_user
    @post_like_ranks = Post.get_ranking(@post)
    #@post_search = Post.get_post_list
    @posts = Post.all
    @keyword = params[:keyword] 
  end

  def show
    @post = Post.find(params[:id])
    @end_user = current_end_user
    @comment = Comment.new
    @comments = @post.comments.includes(:end_user)
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      @post.save_tags(params[:post][:tag])
      redirect_to root_path, notice:"投稿しました。"
    else
      render :index
    end
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      @post.save_tags(params[:post][:tag])
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @posts = Post.find(params[:id])
    @posts.destroy
    @end_user = current_end_user
    redirect_to end_user_path(@end_user.id), notice:"投稿が削除されました。"
  end

  def rank
    @post_like_ranks = Post.get_ranking(@post)
  end

  private

  def post_params
    params.require(:post).permit(:title, :learning_time, :learning_content)
  end
end
