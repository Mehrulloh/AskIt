class SessionsController < ApplicationController
  before_action :require_no_authentication, only: %i[new create]
  before_action :require_authentication, only: :destroy
  before_action :set_user, only: :create

  def new; end

  def create
    if @user&.authenticate(params[:password])
      do_sign_in @ser
      flash[:success] = "Welcome back, #{current_user.name_or_email}!"
      redirect_to root_path
    else
      flash[:deleted] = 'Incorrect email and/or password!'
      redirect_to new_session_path
    end
  end

  def destroy
    sign_out
    flash[:success] = 'You are logged out'
    redirect_to root_path
  end


  private

  def set_user
    @user = User.find_by email: params[:email]
  end

  def do_sign_in(user)
    sign_in(user)
    remember(user) if params[:remember_me] = '1'
  end
end
