class Video < ApplicationRecord
  belongs_to :category
  belongs_to :game
end