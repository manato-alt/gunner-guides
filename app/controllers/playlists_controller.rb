# frozen_string_literal: true

# This controller handles operations related to playlists.
class PlaylistsController < ApplicationController
  def index
    @playlists = current_user.playlists
    @playlist = Playlist.new
  end

  def show
    @playlist = Playlist.find(params[:id])
    videos = @playlist.videos
    @videos = videos.page(params[:page]).per(10)
    render turbo_stream: turbo_stream.update(
      'section',
      partial: 'playlists/show'
    )
  end

  def new
    @playlist = Playlist.new
  end

  def create
    @playlists = current_user.playlists
    @playlist = current_user.playlists.build(playlist_params)
    if @playlist.save
      @playlist = Playlist.new
      render turbo_stream: turbo_stream.update(
        'section',
        partial: 'playlists/index'
      )
    else
      render turbo_stream: turbo_stream.update(
        'new_playlist',
        partial: 'playlists/new'
      )
    end
  end

  def edit
    @playlist = Playlist.find(params[:id])
    render turbo_stream: turbo_stream.update(
      "playlist_edit_#{@playlist.id}",
      partial: 'playlists/edit'
    )
  end

  def update
    @playlist = Playlist.find(params[:id])
    videos = @playlist.videos
    @videos = videos.page(params[:page]).per(10)
    if params[:commit] == 'キャンセル'
      render turbo_stream: turbo_stream.update("playlist_edit_#{params[:id]}") do |page|
        page.html('')
      end
    elsif @playlist.update(playlist_params)
      render turbo_stream: turbo_stream.update(
        "playlist_update_#{params[:id]}",
        partial: 'playlists/playlist_title'
      )
    else
      render turbo_stream: turbo_stream.update(
        "playlist_edit_#{params[:id]}",
        partial: 'playlists/edit'
      )
    end
  end

  def destroy
    @playlist = Playlist.find(params[:id])
    @playlists = current_user.playlists
    @playlist.destroy
    flash.now[:alert] = 'プレイリストを削除しました'
    render turbo_stream: turbo_stream.update(
      'section',
      partial: 'playlists/index'
    )
  end

  def playlist
    @uservideo = Uservideo.find(params[:id])
    @playlists = current_user.playlists
    @video = Video.find(@uservideo.video_id)
    render turbo_stream: turbo_stream.update(
      'section',
      partial: 'shared/playlist'
    )
  end

  def add_video
    @playlist = Playlist.find(params[:id])
    @video = Video.find(params[:video_id])
    @playlist.videos << @video
    @playlists = current_user.playlists
    flash.now[:alert] = 'プレイリストへの登録が完了しました'
    render turbo_stream: turbo_stream.update(
      'section',
      partial: 'shared/playlist'
    )
  end

  private

  def playlist_params
    params.require(:playlist).permit(:title)
  end
end
