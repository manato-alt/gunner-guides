# frozen_string_literal: true

# PlaylistVideoクラスは、アプリケーション内でプレイリストと動画の関連情報を管理します。
class PlaylistVideo < ApplicationRecord
  belongs_to :playlist
  belongs_to :video
end
