class Admins::CommentsController < ApplicationController
  before_action :authenticate_end_user!
  before_action :if_not_admin
  before_action :set_comment, only: [:index, :show, :edit, :update]
  def index
  end

  def show
  end

  def edit
  end

  def update
  end
  
private
  def if_not_admin
    redirect_to root_path unless current_end_user.admin?
  end
  
  def set_comment
    @comment = Comment.find(params[:id])
  end
end
