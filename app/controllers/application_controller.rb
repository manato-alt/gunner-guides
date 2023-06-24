class ApplicationController < ActionController::Base
  private
  def block_login_page_access
    if current_user
      flash[:notice] = "既にログインしています"
      redirect_to root_path
    end
  end

  def check_direct_access
    unless request.referer.present?
      redirect_to root_path, alert: '不正なアクセスです。'
    end
  end
end
