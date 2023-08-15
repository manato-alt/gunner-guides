# frozen_string_literal: true

# Memoクラスは、アプリケーション内でメモ情報を管理します。
class Memo < ApplicationRecord
  belongs_to :video
  belongs_to :user
  validates :content, presence: true
end
