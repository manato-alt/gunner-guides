# frozen_string_literal: true

# Gameクラスは、アプリケーション内でゲームのデータとロジックを管理します。
class Game < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  has_many :videos, dependent: :destroy
end
