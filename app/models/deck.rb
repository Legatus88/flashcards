class Deck < ApplicationRecord
  has_many :card
  belongs_to :user

  scope :current_deck, ->(current_deck_id) { where('deck_id == ?', current_deck_id) }
end
