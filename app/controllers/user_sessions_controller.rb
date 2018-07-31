class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      redirect_back_or_to(root_path, notice: "#{t('common.login_suc')}")
    else
      flash.now[:alert] = "#{t('common.login_failed')}"
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to(:users, notice: "#{t('common.logged_out')}")
  end
end
