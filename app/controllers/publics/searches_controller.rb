class Publics::SearchesController < ApplicationController
  def search
    @search = Post.ransack(params[:q])
    @end_user = current_end_user
    @search_posts = @search.result.order(created_at: :desc).page(params[:page])
  end
end
