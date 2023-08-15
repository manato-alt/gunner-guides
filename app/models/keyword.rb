# frozen_string_literal: true

# Keywordクラスは、アプリケーション内でキーワード情報を管理します。
class Keyword < ApplicationRecord
  belongs_to :category
end
