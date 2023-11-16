class Publics::SearchesController < ApplicationController
  def search
    @search = Post.ransack(params[:q])
    @search_posts = @search.result.order(created_at: :desc).page(params[:page])
  end
end
