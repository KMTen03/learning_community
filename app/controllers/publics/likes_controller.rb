class Publics::LikesController < ApplicationController
  before_action :authenticate_end_user!
  def create #いいね作成
    @post_like = Like.new(end_user_id: current_end_user.id, post_id: params[:post_id])
    @post_like.save
    redirect_to post_path(params[:post_id]) 
  end

  def destroy #いいね削除
    @post_like = Like.find_by(end_user_id: current_end_user.id, post_id: params[:post_id])
    @post_like.destroy
    redirect_to post_path(params[:post_id])
  end
end
