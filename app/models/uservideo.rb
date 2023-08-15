# frozen_string_literal: true

# Uservideoクラスは、アプリケーション内でユーザーと動画の関連情報を管理します。
class Uservideo < ApplicationRecord
  belongs_to :user
  belongs_to :video
end
