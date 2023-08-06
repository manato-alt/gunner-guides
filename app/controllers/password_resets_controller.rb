class PasswordResetsController < ApplicationController
  before_action :block_login_page_access
  def create
    @user = User.find_by(email: params[:email])
    @user.deliver_reset_password_instructions! if @user
    redirect_to login_path, notice: "送信しました"
  end

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])
    if @user.blank?
      not_authenticated
      return
    end
  end

  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)
    if @user.blank?
      not_authenticated
    end
    @user.password_confirmation = params[:user][:password_confirmation]
    if params[:user][:password].blank?
      flash.now[:danger] = 'パスワードを入力してください'
      render :edit, status: :unprocessable_entity
    elsif @user.change_password(params[:user][:password])
      redirect_to login_path, notice: 'パスワードを変更しました。'
    else
      flash.now[:danger] = 'パスワードの変更に失敗しました。'
      render :edit, status: :unprocessable_entity
    end
  end

  def new
  end
end
