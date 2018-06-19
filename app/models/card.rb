class Card < ApplicationRecord
  with_options presence:true do |a|
  	a.validates :original_text, :words_are_different?
  	a.validates :translated_text, :words_are_different?
  	a.validates :review_date
  end

  def words_are_different?
    ot = original_text.split(' ').first.downcase
    tt = translated_text.split(' ').first.downcase
    ot != tt
  end

  before_create :plus_three_days

  private
    def plus_three_days
      self.review_date = Date.today + 3.day
    end
end
