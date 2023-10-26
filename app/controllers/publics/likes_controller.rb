class Publics::LikesController < ApplicationController
  def create
    @like = Like.create(end_user_id: current_end_user.id, post_id: @post.id)
  end

  def destroy
    @like = Like.find_by(end_user_id: current_end_user.id, post_id: @post.id)
    @like.destroy
  end
  
  private
  def set_post
    @post = Post.find(params[:post_id])
  end
end
