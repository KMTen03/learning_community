class Publics::SessionsController < Devise::SessionsController

  
  def guest_sign_in
    @end_user = EndUser.guest
    sign_in @end_user
    redirect_to posts_path, notice: 'ゲストユーザーとしてログインしました。'
  end
  
  def end_user_state
    @end_user = end_user.find_by(email: params[:end_user][:email])
    if @end_user
      if @end_user.valid_password?(params[:end_user][:password]) && @end_user.is_deleted
        flash[:notice] = "退会済みです。再度ご登録をしてご利用ください。"
        redirect_to new_end_user_session_path
      end
    end
  end
  
  def after_sign_in_path_for(resource)
    posts_path
  end
  
  def after_sign_out_path_for(resource)
    new_end_user_session_path
  end
  

end
