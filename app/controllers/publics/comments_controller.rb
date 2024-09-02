class Publics::CommentsController < ApplicationController
  before_action :authenticate_end_user!
  
  def create #コメント作成時
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to post_path(@comment.post)
    else
      @post = @comment.post
      @comments = @post.comments.includes(:user)
      render "posts/show" #投稿詳細ページへ移動
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id], post_id: params[:post_id])
    @comment.destroy
    redirect_to post_path(@comment.post)
  end
  
private

  def comment_params
    params.require(:comment).permit(:content).merge(end_user_id: current_end_user.id, post_id: params[:post_id])
  end

end
