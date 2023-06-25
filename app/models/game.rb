class Game < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  has_many :videos, dependent: :destroy
end
