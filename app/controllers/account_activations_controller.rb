class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by email: params[:email]
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate_account
      log_in user
      flash[:success] = t ".activated_success"
      redirect_to user
    else
      flash[:danger] = t ".activated_unsuccess"
      redirect_to root_url
    end
  end
end
