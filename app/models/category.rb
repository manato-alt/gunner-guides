# frozen_string_literal: true

# Categoryモデルは、コンテンツなどを分類するためのカテゴリ情報を管理します。
class Category < ApplicationRecord
  has_many :keywords, dependent: :destroy
  has_many :videos, dependent: :destroy
end
