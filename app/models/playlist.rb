# frozen_string_literal: true

# Playlistクラスは、アプリケーション内でプレイリスト情報を管理します。
class Playlist < ApplicationRecord
  validates :title, presence: true
  belongs_to :user
  has_many :playlist_videos, dependent: :destroy
  has_many :videos, through: :playlist_videos
end
