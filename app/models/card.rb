class Card < ApplicationRecord
  with_options presence:true do |a|
   	a.validates :original_text
    a.validates :translated_text
  	a.validates :review_date
  end
  
  validate :words_are_different?

  def words_are_different?
    return errors.add(:empty_fields, 'Fields are empty!') if original_text.empty? || translated_text.empty?
    ot = original_text.split(' ').first.downcase
    tt = translated_text.split(' ').first.downcase
    errors.add(:difference, 'words are the same') if ot == tt
  end

  before_create :plus_three_days

  def translation_correct?(user_text, real_translation)
    if user_text.downcase.eql? real_translation.downcase
      plus_three_days
      true
    else
      false
    end
  end

  private
    def plus_three_days
      self.review_date = Date.today + 3.day
    end
end
