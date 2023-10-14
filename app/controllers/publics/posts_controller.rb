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
    @post = Post.new(params[:id])
    @post.save
  end

  def update
  end

  def destroy
  end
end
