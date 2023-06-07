class ApplicationController < ActionController::Base
  private
  def block_login_page_access
    if current_user
      flash[:notice] = "既にログインしています"
      redirect_to root_path
    end
  end
end
