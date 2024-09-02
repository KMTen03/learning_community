class Publics::EndUsersController < ApplicationController
  before_action :ensure_guest_user, only: [:edit, :update, :withdraw]
  before_action :is_matching_login_user, only: [:edit, :update, :withdraw]
  

  def show
    @end_user = is_matching_end_user
    @posts = @end_user.posts.page(params[:page])
  end

  def edit
    @end_user = is_matching_end_user
  end

  def update #ユーザー情報更新時
    @end_user = EndUser.find(params[:id])
    if @end_user.update(end_user_params)
      redirect_to end_user_path(@end_user.id)
    else
      render :edit
    end
  end

  def likes 
    @end_user = EndUser.find(params[:id])
    likes = Like.where(end_user_id: current_end_user.id).pluck(:post_id)
    @likes_posts = Post.find(likes)
    @likes_posts = Kaminari.paginate_array(@likes_posts).page(params[:page]).per(5)
  end

  def ranking
    @end_user_ranks = EndUser.ranking
  end

  def withdraw
    @end_user = EndUser.find(current_end_user.id)
    @end_user.update(is_deleted: true)
    reset_session
    redirect_to new_end_user_session_path, notice: '退会処理を実行しました。'
  end
  
  def guest_sign_in
    @end_user = EndUser.guest
    sign_in end_user
    redirect_to posts_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  private

  def end_user_params
    params.require(:end_user).permit(:name, :introduce, :profile_image)
  end
  
  def ensure_guest_user
   if current_end_user.guest_user?
     redirect_to root_path, notice: "ゲストユーザーはプロフィール編集できません。"
   end
  end

  def is_matching_login_user #ログインしているユーザーと同一ユーザーであるか
    @end_user = EndUser.find(params[:id])
    unless @end_user == current_end_user
      redirect_to end_user_path(current_end_user.id)
    end
  end
end
