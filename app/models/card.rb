class Card < ApplicationRecord
  validates :original_text, :translated_text, :review_date, presence: true
  validates :translated_text, presence: true, unless: :words_are_equal?

  def words_are_equal?
    ot = original_text.split(' ').first.downcase
    tt = translated_text.split(' ').first.downcase
    ot == tt
  end

end
