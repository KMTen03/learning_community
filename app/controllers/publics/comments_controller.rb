class Publics::CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.end_user_id = current_end_user.id
    @comment.post_id = @post.id
    @comment.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    @post_comments = @post.comments
    Comment.find_by(id: params[:id], post_id: params[:post_id]).destroy
  end
  
private

  def comment_params
    params.require(:comment).permit(:content)
  end

end
