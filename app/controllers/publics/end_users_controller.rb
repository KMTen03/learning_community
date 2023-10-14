class Publics::EndUsersController < ApplicationController
  def show
    @end_user = End_user.find(params[:id])
  end

  def edit
  end

  def update
  end

  def withdraw
  end
end
