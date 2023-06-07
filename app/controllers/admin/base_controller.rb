class Admin::BaseController < ApplicationController
  before_action :require_login
  before_action :check_admin
  layout 'admin/layouts/application'

  private

  def not_authenticated
    flash[:warning] = t('defaults.message.require_login')
    redirect_to admin_login_path
  end

  def check_admin
    redirect_to root_path, warning: t('defaults.message.not_authorized') unless current_user.admin?
  end

  def block_login_page_access
    if current_user
      flash[:notice] = "既にログインしています"
      redirect_to root_path
    end
  end

end
