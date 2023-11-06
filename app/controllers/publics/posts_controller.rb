class Publics::PostsController < ApplicationController
  before_action :authenticate_end_user!
  
  def new
  end

  def index
    @posts = Post.all
    @post = Post.new
    @end_user = current_end_user
    if params[:keyword]
      @posts = @posts.search(params[:keyword]).page(params[:page])
    else
      @posts = @posts.page(params[:page])
    end
    @keyword = params[:keyword]
  end

  def show
    @post = Post.find(params[:id])
    @end_user = current_end_user
    @comment = Comment.new
    @comments = @post.comments.includes(:end_user)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.end_user_id = current_end_user.id
    if @post.save
      redirect_to post_path(@post.id)
    else
      @posts = Post.all
      render :index
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post.id)
    else
      @posts = Post.all
      render :index
    end
  end

  def destroy
    @posts = Post.find(params[:id])
    @posts.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :learning_time, :learning_content)
  end

  def is_matching_login_user
    @end_user = EndUser.find(params[:id])
    unless @post.end_user == current_user
      redirect_to posts_path
    end
  end
end
