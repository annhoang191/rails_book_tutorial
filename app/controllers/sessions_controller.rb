class SessionsController < ApplicationController
  def new; end


  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == Settings.session.remember_me_true ? remember(user) : forget(user)
        redirect_back_or user
      else
        flash[:warning] = t ".not_activate"
        redirect_to root_url
      end
    else
      flash.now[:danger] = t ".login_fail"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
