class MemosController < ApplicationController
  def memo
    @memo = Memo.new
    @uservideo = Uservideo.find(params[:id])
    @user = User.find(@uservideo.user_id)
    @video = Video.find(@uservideo.video_id)
    @memos = Memo.where(user_id: @user.id, video_id: @video.id)
    @memos = @memos.page(params[:page]).per(20)
    if params[:sort].present? && ["newest", "oldest"].include?(params[:sort])
      @memos = @memos.order(updated_at: params[:sort] == "newest" ? :desc : :asc)
      session[:selected_sort] = params[:sort]
    else
      session[:selected_sort] = nil
    end
    @memos = @memos.order(updated_at: :desc) unless params[:order].present?

    render turbo_stream: turbo_stream.update(
      'section',
      partial: 'shared/memo',
    )
  end

  def create
    @memo = Memo.new(memo_params)
    @uservideo = Uservideo.find_by(user_id: @memo.user_id, video_id: @memo.video_id)
    @memos = Memo.where(user_id: @memo.user_id, video_id: @memo.video_id) # @memos を再度取得
    @memos = @memos.order(updated_at: :desc)
    @memos = @memos.page(params[:page]).per(20)
    @user = User.find(@uservideo.user_id)
    @video = Video.find(@uservideo.video_id)  

    respond_to do |format|
      if @memo.save
        @memo = Memo.new
        format.turbo_stream { render turbo_stream: turbo_stream.update('section', partial: 'shared/memo') }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.update('section', partial: 'shared/memo'), locals: { memo: @memo } }
      end
    end
  end

  def edit
    @memo = Memo.find(params[:id])
    render turbo_stream: turbo_stream.update(
      "memo_edit_#{@memo.id}",
      partial: 'shared/memo_edit',
    )
  end

  def update
    @memo = Memo.find(params[:id])
    if request.referer.include?('mypage')
      if params[:commit] == 'キャンセル'
        render turbo_stream: turbo_stream.update("memo_edit_#{params[:id]}") do |page|
          page.html("")
        end
      elsif @memo.update(memo_params)
        render turbo_stream: turbo_stream.update(
          "memo_update_#{params[:id]}", # memo_update_ をプレフィックスにした ID を指定する
          partial: 'shared/mypage_memo_index',
          locals: { memo: @memo }
        )
      else
        render turbo_stream: turbo_stream.update(
          "section", # memo_update_ をプレフィックスにした ID を指定する
          partial: 'shared/mypage_memo_index',
          locals: { memo: @memo }
        )
      end
    else
      if params[:commit] == 'キャンセル'
        # キャンセルボタンが押された場合の処理
        render turbo_stream: turbo_stream.update(
          "memo_update_#{params[:id]}", # memo_update_ をプレフィックスにした ID を指定する
          partial: 'shared/memo_index',
          locals: { memo: @memo }
        )
      elsif @memo.update(memo_params)
        @uservideo = Uservideo.find_by(user_id: @memo.user_id, video_id: @memo.video_id)
        @memos = Memo.where(user_id: @memo.user_id, video_id: @memo.video_id)
        render turbo_stream: turbo_stream.update(
          "memo_update_#{params[:id]}", # memo_update_ をプレフィックスにした ID を指定する
          partial: 'shared/memo_index',
          locals: { memo: @memo }
        )
      else
        @uservideo = Uservideo.find_by(user_id: @memo.user_id, video_id: @memo.video_id)
        @memos = Memo.where(user_id: @memo.user_id, video_id: @memo.video_id)

        render turbo_stream: turbo_stream.update(
          "memo_edit_#{params[:id]}", # memo_edit_ をプレフィックスにした ID を指定する
          partial: 'shared/memo_edit',
          locals: { memo: @memo }
        )
      end
    end
  end

  def destroy
    @memo = Memo.find(params[:id])
    @memo.destroy
    render turbo_stream: turbo_stream.update(
        "memo_update_#{params[:id]}",
      )
  end
  
  private
  
  def memo_params
    params.require(:memo).permit(:content, :user_id, :video_id)
  end
end
