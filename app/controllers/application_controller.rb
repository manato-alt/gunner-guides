# frozen_string_literal: true

# Base controller for the entire application.
class ApplicationController < ActionController::Base
  private

  def block_login_page_access
    return unless current_user

    flash[:notice] = '既にログインしています'
    redirect_to root_path
  end

  def check_direct_access
    return if request.referer.present?

    redirect_to root_path, alert: '不正なアクセスです。'
  end
end
