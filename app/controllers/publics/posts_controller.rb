class Publics::PostsController < ApplicationController
  before_action :authenticate_end_user!

  def new
  end

  def index
    @post = Post.new
    @posts = Post.all
    @q = Post.ransack(params[:q])
    @posts = @q.result
    @end_user = current_end_user
    @post_like_ranks = Post.find(Like.group(:post_id).order('count(post_id) desc').pluck(:post_id))
    if params[:new_post]
      @posts = Post.new_post
    elsif params[:old_post]
      @posts = Post.old_post
    elsif params[:tag_id].present?

      @posts = Tag.find(params[:tag_id]).posts
    elsif params[:keyword]
      @posts = @posts.search(params[:keyword]).page(params[:page])
    else
      Post.all
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
      params[:post][:tag_ids].each do |tag_id|
      PostTag.create(post_id: @post.id, tag_id: tag_id)
    end
    
      redirect_to posts_path, notice:"投稿しました。"
    else
      @posts = Post.all
      render :index, notice:"投稿に失敗しました。"
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post.id), notice:"変更を保存しました。"
    else
      @posts = Post.all
      render :index, notice:"変更を保存に失敗しました。"
    end
  end

  def destroy
    @posts = Post.find(params[:id])
    @posts.destroy
    redirect_to posts_path, notice:"投稿が削除されました。"
  end

  def rank
    @post_like_ranks = Post.find(Like.group(:post_id).order('count(post_id) desc').pluck(:post_id))
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
