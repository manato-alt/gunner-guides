# frozen_string_literal: true

# Videoクラスは、アプリケーション内で動画情報を管理します。
class Video < ApplicationRecord
  belongs_to :category
  belongs_to :game
  has_many :user_videos, class_name: 'Uservideo', dependent: :destroy
  has_many :users, through: :user_videos
  has_many :memos, dependent: :destroy
  has_many :playlist_videos, dependent: :destroy
  has_many :playlists, through: :playlist_videos
end
