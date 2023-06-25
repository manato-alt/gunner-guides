class Video < ApplicationRecord
  belongs_to :category
  belongs_to :game
  has_many :user_videos, class_name: 'Uservideo', dependent: :destroy
  has_many :users, through: :user_videos
  has_many :memos, dependent: :destroy
end