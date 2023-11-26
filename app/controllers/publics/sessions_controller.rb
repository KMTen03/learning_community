class Publics::SessionsController < Devise::SessionsController

  private
  def guest_sign_in
    @end_user = EndUser.guest
    sign_in @end_user
    redirect_to posts_path, notice: 'ゲストユーザーとしてログインしました。'
  end
  
  def after_sign_in_path_for(resource)
    posts_path
  end
  
  def after_sign_out_path_for(resource)
    new_end_user_session_path
  end
end
