class Publics::PostsController < ApplicationController
  before_action :authenticate_end_user!

  def index
    @post = Post.new
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true)
    @end_user = current_end_user
    @post_like_ranks = Post.get_ranking(@post)
    # @posts = Post.get_post_list(params[:new_post], params[:old_post], params[:tag_id], params[:keyword])
    if params[:new_post]
      @posts = Post.new_post
    elsif params[:old_post]
      @posts = Post.old_post
    elsif params[:tag_id].present?
      @posts = Tag.find(params[:tag_id]).posts
    elsif params[:keyword]
      @posts = @posts.search(params[:keyword])
    else
      @posts = Post.all
    end
    @posts = @posts.page(params[:page]).per(5)
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
      params[:post][:tag_ids]&.each do |tag_id|
      PostTag.create(post_id: @post.id, tag_id: tag_id)
    end
      redirect_to post_path(@post.id), notice:"投稿しました。"
    else
      @end_user = current_end_user
      @posts = Post.all.page(params[:page]).per(5)
      @q = Post.ransack(params[:q])
      @keyword = params[:keyword]
      @post_like_ranks = Post.get_ranking(@post)
      render :index, notice:"投稿に失敗しました。"
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      @post.post_tags.destroy_all
      params[:post][:tag_ids]&.each do |tag_id|
      PostTag.create(post_id: @post.id, tag_id: tag_id)
    end
      redirect_to post_path(@post.id), notice:"変更を保存しました。"
    else
      @posts = Post.all
      render :index, notice:"変更を保存に失敗しました。"
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
