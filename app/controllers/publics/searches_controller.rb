class Publics::SearchesController < ApplicationController
  before_action :authenticate_end_user!
  
  def search
    @range = params[:range]
    @word = params[:word]
    
    if @range == "EndUser"
      @posts = Post.looks(params[:search], params[:word])
    else
      @tags = Tag.looks(params[:search], params[:word])
    end
  end
end
