# frozen_string_literal: true

# This controller handles operations related to purposes.
class PurposesController < ApplicationController
  def setting
    @game = Game.find_by!(title: params[:title])
    @videos = Video.joins(:category).where(categories: { name: 'setting' },
                                           game_id: @game.id).page(params[:page]).per(12)
  end

  def training
    @game = Game.find_by!(title: params[:title])
    @videos = Video.joins(:category).where(categories: { name: 'training' },
                                           game_id: @game.id).page(params[:page]).per(12)
  end

  def information
    @game = Game.find_by!(title: params[:title])
    @videos = Video.joins(:category).where(categories: { name: 'information' },
                                           game_id: @game.id).page(params[:page]).per(12)
  end

  def show
    @memo = Memo.new
    @game = Game.find_by!(title: params[:title])
    @video = Video.find(params[:id])
    return unless current_user

    @uservideo = Uservideo.find_by(user_id: current_user.id, video_id: @video.id)
    return if @uservideo

    @uservideo = Uservideo.create(user_id: current_user.id, video_id: @video.id, watched_status: 1,
                                  watched_at: Time.now)
  end
end
