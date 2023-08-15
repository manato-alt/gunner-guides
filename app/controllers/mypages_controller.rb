# frozen_string_literal: true

# Controller for handling user profile pages and related actions.
class MypagesController < ApplicationController
  before_action :require_login
  before_action :check_direct_access, only: %i[watch complete memo]
  def index
    videos = Video.where(id: Uservideo.where(user_id: current_user.id, watched_status: 1).pluck(:video_id))
    @videos = videos.page(params[:page]).per(12)
  end

  def watch
    videos = Video.where(id: Uservideo.where(user_id: current_user.id, watched_status: 1).pluck(:video_id))
    @videos = videos.page(params[:page]).per(12)

    if params[:game_id].present?
      @videos = @videos.where(game_id: params[:game_id])
      session[:selected_game_id] = params[:game_id]
    else
      session[:selected_game_id] = nil # セッションをクリア
    end

    if params[:category_id].present?
      @videos = @videos.where(category_id: params[:category_id])
      session[:selected_category_id] = params[:category_id] # 選択されたcategory_idをセッションに保存
    else
      session[:selected_category_id] = nil # セッションをクリア
    end

    render turbo_stream: turbo_stream.update(
      'section',
      partial: 'shared/mypage_watched'
    )
  end

  def complete
    videos = Video.where(id: Uservideo.where(user_id: current_user.id, watched_status: 2).pluck(:video_id))
    @videos = videos.page(params[:page]).per(12)

    if params[:game_id].present?
      @videos = @videos.where(game_id: params[:game_id])
      session[:selected_game_id] = params[:game_id]
    else
      session[:selected_game_id] = nil # セッションをクリア
    end

    if params[:category_id].present?
      @videos = @videos.where(category_id: params[:category_id])
      session[:selected_category_id] = params[:category_id] # 選択されたcategory_idをセッションに保存
    else
      session[:selected_category_id] = nil # セッションをクリア
    end

    render turbo_stream: turbo_stream.update(
      'section',
      partial: 'shared/mypage_completed'
    )
  end

  def memo
    @memos = Memo.includes(video: :game).where(user_id: current_user.id)
    @memos = @memos.page(params[:page]).per(12)

    if params[:game_id].present?
      @memos = @memos.where(videos: { game_id: params[:game_id] })
      session[:game_id] = params[:game_id]
    else
      session[:game_id] = nil
    end

    if params[:order].present? && %w[newest oldest].include?(params[:order])
      @memos = @memos.order(updated_at: params[:order] == 'newest' ? :desc : :asc)
      session[:selected_sort] = params[:order]
    else
      session[:selected_sort] = nil
    end

    @memos = @memos.order(updated_at: :desc) unless params[:order].present?

    render turbo_stream: turbo_stream.update(
      'section',
      partial: 'shared/mypage_memo'
    )
  end

  def playlist
    @playlists = current_user.playlists
    render turbo_stream: turbo_stream.update(
      'section',
      partial: 'playlists/index'
    )
  end
end
