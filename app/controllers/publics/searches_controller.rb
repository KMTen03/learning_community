class Publics::SearchesController < ApplicationController
  before_action :authenticate_end_user!
  
  def search
    @search = Post.ransack(params[:q])
    @end_user = current_end_user
    @search_posts = @search.result.order(created_at: :desc).page(params[:page])
  end
end
