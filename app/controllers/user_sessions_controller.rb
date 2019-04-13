class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create, :index ]

  def new
    @user = User.new
  end

  def create
    @user = login(params[:user][:email], params[:user][:password], params[:user][:remember])
    if @user
      redirect_to root_path, notice: 'ログイン成功しました'
    else
      flash.now[:alert] = "ログイン失敗です"
      render :new
    end
  end

  def destroy
    logout
    redirect_to(:users, notice: 'ログアウト！')
  end
end
