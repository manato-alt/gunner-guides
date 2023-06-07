class Admin::UsersController < Admin::BaseController
  def index
    @users = User.page(params[:page]).per(10)

    # パラメータにemailが指定されている場合、emailでの曖昧検索を実行
    if params[:email].present?
      @users = @users.where("email LIKE ?", "%#{params[:email]}%")
    end

    # パラメータにroleが指定されている場合、roleでの絞り込みを実行
    if params[:role].present?
      @users = @users.where(role: params[:role])
    end

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
