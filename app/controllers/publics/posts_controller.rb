class Publics::PostsController < ApplicationController
  def new
  end

  def index
    @posts = Post.all
    @post = Post.new
    @end_user = current_end_user
  end

  def show
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_end_user
    if @post.save
      redirect_to post_path(@post.id)
    else
      @posts = Post.all
      render :index
    end
  end

  def update
  end

  def destroy
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :learning_time, :learning_content)
  end
end
