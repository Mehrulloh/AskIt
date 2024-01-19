class UsersController < ApplicationController
  before_action :require_no_authentication
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the app, #{current_user.name_or_email}!"
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :lastname, :email, :password, :password_confirmation)
  end
end