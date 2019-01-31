class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build micropost_params
    if @micropost.save
      flash[:success] = t ".success"
      redirect_to root_url
    else
      @feed_items = []
      flash[:danger] = t ".fail"
      redirect_to root_url
    end
  end

  def destroy
    if @micropost.destroy
      flash[:success] = t ".deleted_success"
      redirect_to request.referrer || root_url
    else
      flash[:danger] = t ".deleted_fail"
      redirect_to root_url
    end
  end
  private

  def micropost_params
    params.require(:micropost).permit :content, :picture
  end

  def correct_user
    @micropost = current_user.microposts.find_by id: params[:id]
    redirect_to root_url if @micropost.nil?
  end
end
