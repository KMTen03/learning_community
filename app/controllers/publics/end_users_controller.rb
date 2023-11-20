class Publics::EndUsersController < ApplicationController

  def show
    @end_user = current_end_user
    @end_user = EndUser.find(params[:id])
    @posts = @end_user.posts.page(params[:page])
  end

  def edit
    @end_user = current_end_user
    @end_user = EndUser.find(params[:id])
  end

  def update
    @end_user = EndUser.find(params[:id])
    if @end_user.update(end_user_params)
      redirect_to end_user_path(@end_user.id)
    else
      render :edit
    end
  end

  def likes
    @end_user = EndUser.find(params[:id])
    likes = Like.where(end_user_id: @end_user.id).pluck(:post_id)
    @likes_posts = Post.find(likes)
  end

  def guest_sign_in
    @end_user = EndUser.guest
    sign_in end_user
    redirect_to posts_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  def ranking
    @end_user_ranks = EndUser.find(EndUserPost.group(:end_user_id).order('count(post_id) desc').limit(10).pluck(:end_user_id))
  end

  def confirm
  end

  def withdraw
    @end_user = EndUser.find(params[:id])
    @end_user.update(is_deleted: true)
    reset_session
    redirect_to root_path, notice: '退会処理を実行しました。'
  end

  private

  def end_user_params
    params.require(:end_user).permit(:name, :introduce, :profile_image)
  end


  def is_matching_login_user
    @end_user = EndUser.find(params[:id])
    unless @end_user == current_user
      redirect_to end_user_path(current_user.id)
    end
  end
end
