class Publics::SessionsController < Devise::SessionsController
  def guest_sign_in
    @end_user = EndUser.guest
    sign_in @end_user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end
  
protected
  def after_sign_in_path_for(resource)
    posts_path
  end
end
