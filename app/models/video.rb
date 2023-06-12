class Video < ApplicationRecord
  belongs_to :category
  belongs_to :game
  has_many :user_videos
  has_many :users, through: :user_videos
end