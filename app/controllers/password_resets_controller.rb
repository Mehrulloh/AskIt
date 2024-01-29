class PasswordResetsController < ApplicationController
  before_action :require_no_authentication
  before_action :set_user, only: %i[edit update]

  def create
    @user = User.find_by email: params[:email]

    if @user.present?
      @user.set_password_reset_token
      PasswordResetMailer.with(user: @user).reset_email.deliver_later
    end

    flash[:success] = 'Email was sended!'
    redirect_to new_session_path
  end

  def edit
  end

  def update
    if @user.update user_params
      flash[:success] = 'Password was reset!'
      redirect_to new_session_path
    else
      render :edit
    end
  end


  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation).merge(admin_edit: true)
  end

  def set_user
    redirect_to(new_session_path, flash: { deleted: "Could not reset your password" }) and return unless params[:user].present?
    @user = User.find_by email: params[:user][:email],
                         password_reset_token: params[:user][:password_reset_token]
    redirect_to(new_session_path, flash: { deleted: "Could not reset your password" }) unless @user&.password_reset_period_valid?
  end
end