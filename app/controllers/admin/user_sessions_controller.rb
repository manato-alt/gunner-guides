class Admin::UserSessionsController < Admin::BaseController
  before_action :block_login_page_access, only: %i[new create]
  skip_before_action :require_login, only: %i[new create]
  skip_before_action :check_admin, only: %i[new create]
  layout 'layouts/application'

  def new; end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_to admin_root_path
    else
      render :new
    end
  end

  def destroy
    logout
    redirect_to admin_login_path, success: t('.success')
  end

  private

  def block_login_page_access
    if current_user
      flash[:notice] = "既にログインしています"
      redirect_to admin_root_path
    end
  end
end