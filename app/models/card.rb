class Card < ApplicationRecord

  has_attached_file :image, styles: { thumb: "300x300#" }
  belongs_to :user
  
  with_options presence:true do |a|
   	a.validates :original_text
    a.validates :translated_text
  	a.validates :review_date
  end
  
  validate :words_are_different?

  validates_attachment :image,
                     content_type: { content_type: /\Aimage\/.*\z/ },
                     size: { less_than: 1.megabyte }

  def words_are_different?
    return errors.add(:empty_fields, 'Fields are empty!') if original_text.empty? || translated_text.empty?
    ot = original_text.split(' ').first.downcase
    tt = translated_text.split(' ').first.downcase
    errors.add(:difference, 'words are the same') if ot == tt
  end

  scope :expired, -> { where('review_date <= ?', DateTime.now) }

  before_create :plus_three_days

  def translation_correct?(user_text)
    if user_text.casecmp(original_text).zero?
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
