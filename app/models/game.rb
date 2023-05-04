class Game < ApplicationRecord
  validates :title, presence: true, uniqueness: true
end
