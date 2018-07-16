class Deck < ApplicationRecord
  has_many :card
  belongs_to :user
end
