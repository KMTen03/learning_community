class Admins::EndUsersController < ApplicationController
  def index
    @end_users = EndUser.page(params[:page])
  end

  def show
  end

  def edit
  end

  def update
  end
  
  private
  def end_user_params
    params.require(:end_user).permit(:name, :email, :introduce, :is_deleted)
  end
end
