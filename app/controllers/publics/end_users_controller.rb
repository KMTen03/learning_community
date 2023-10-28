class Publics::EndUsersController < ApplicationController
  def show
    @post = Post.new
    @end_user = EndUser.find(params[:id])
    @posts = @end_user.posts.page(params[:page])
  end


  def edit
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

  def withdraw
    @end_user = current_end_user
    @end_user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end
  
  def favorites
    @end_user = EndUser.find(params[:id])
    favorites = Favorite.where(end_user_id: @end_user.id).pluck(:post_id)
    @favorites_posts = Post.find(favorites)
    @post = Post.find(params[:id])
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
