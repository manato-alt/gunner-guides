class Category < ApplicationRecord
  has_many :keywords, dependent: :destroy
  has_many :videos, dependent: :destroy
end
