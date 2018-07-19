class Deck < ApplicationRecord
  has_many :card, dependent: :destroy
  belongs_to :user
end
