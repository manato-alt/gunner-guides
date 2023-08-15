# frozen_string_literal: true

module Admin
  # Controller for managing user data in the admin panel.
  class UsersController < BaseController
    def index
      @users = User.page(params[:page]).per(10)

      # パラメータにemailが指定されている場合、emailでの曖昧検索を実行
      @users = @users.where('email LIKE ?', "%#{params[:email]}%") if params[:email].present?

      # パラメータにroleが指定されている場合、roleでの絞り込みを実行
      return unless params[:role].present?

      @users = @users.where(role: params[:role])

      # ページネーションを適用
    end

    def show
      @user = User.find(params[:id])
      @watched_count = Uservideo.where(user_id: @user.id, watched_status: [1, 2]).count
      @completed_count = Uservideo.where(user_id: @user.id, watched_status: 2).count
    end

    def destroy
      @user = User.find(params[:id])
      @user.destroy
    end
  end
end
