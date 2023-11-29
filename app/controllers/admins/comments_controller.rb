class Admins::CommentsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @comments = Comment.page(params[:page])
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def edit
  end

  def update
  end
  
  def destroy
    Comment.find(params[:id]).destroy
    redirect_to admins_comments_path(params[:post_id]), notice: "不適切なコメントを削除しました。"
  end
  
private

  def comment_params
    params.require(:comment).permit(:content).merge(end_user_id: current_end_user.id, post_id: params[:post_id])
  end
end
