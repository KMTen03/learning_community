class Publics::PostsController < ApplicationController
  def new
  end

  def index
    @posts = Post.all
    @post = Post.new
    @end_user = current_end_user
  end

  def show
    @post = Post.new
    @end_user = current_end_user
    @post = Post.find(params[:id])
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
      flash[:notice] = "You have updated book successfully."
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
