class Publics::RanksController < ApplicationController
  def rank
    @post_like_ranks = Post.find(Like.group(:post_id).order('count(post_id) desc').pluck(:post_id))

  end

end
