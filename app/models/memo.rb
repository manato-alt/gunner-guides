class Memo < ApplicationRecord
  belongs_to :video
  belongs_to :user
  validates :content, presence: true
end
