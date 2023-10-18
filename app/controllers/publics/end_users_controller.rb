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
    if @end_user.update(end_user_params)
      redirect_to end_user_path(@end_user.id)
    else
      render :edit
    end
  end

  def withdraw
  end

  # private

  # def end_user_params
  #   params.require(:end_user).permit(:name, :introduce, :profile_image)
  # end

  # def is_matching_login_user
  #   @end_user = EndUser.find(params[:id])
  #   unless @end_user == current_user
  #     redirect_to end_user_path(current_user.id)
  #   end
  # end
end
