class User < ApplicationRecord
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  has_many :cards 
  has_many :decks
  has_one  :current_deck, class_name: 'Deck'
  has_many :authentications, dependent: :destroy

  accepts_nested_attributes_for :authentications

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true

  def change_deck 
    self.current_deck = self.decks.select { |deck| deck.id.eql? self.current_deck_id }.first
    save
  end
end
