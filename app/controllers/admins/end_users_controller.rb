class Admins::EndUsersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @end_users = EndUser.page(params[:page])
  end

  def show
    @end_user = EndUser.find(params[:id])
    @posts = @end_user.posts.page(params[:page])
  end

  def edit
    @end_user = EndUser.find(params[:id])
  end

  def update
    @end_user = EndUser.find(params[:id])
    if @end_user.update(end_user_params)
      flash[:notice] = "会員情報を変更しました。"
      redirect_to admins_end_user_path(@end_user.id)
    else
      render :edit
    end
  end

  private
  def end_user_params
    params.require(:end_user).permit(:name, :email, :introduce, :is_deleted)
  end
end
