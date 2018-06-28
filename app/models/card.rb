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

  scope :expired, -> { where('review_date <= ?', DateTime.now) }

  before_create :plus_three_days

  def translation_correct?(user_text)
    if user_text.downcase.eql?(self.original_text.downcase)
      plus_three_days
      self.save
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
