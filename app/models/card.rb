class Card < ApplicationRecord

  has_attached_file :image, styles: { thumb: "300x300#" }
  belongs_to :user
  belongs_to :deck
  
  with_options presence:true do |a|
   	a.validates :original_text
    a.validates :translated_text
  	a.validates :review_date
  end
  
  validate :words_are_different?

  validates_attachment :image,
                     content_type: { content_type: /\Aimage\/.*\z/ },
                     size: { less_than: 1.megabyte }

  TIMES = {
    "1" => 0.5.days,
    "2" => 3.days,
    "3" => 7.days,
    "4" => 14.days,
    "5" => 1.months
  }

  def words_are_different?
    return errors.add(:empty_fields, 'Fields are empty!') if original_text.empty? || translated_text.empty?
    ot = original_text.split(' ').first.downcase
    tt = translated_text.split(' ').first.downcase
    errors.add(:difference, 'words are the same') if ot == tt
  end

  scope :expired, -> { where('review_date <= ?', DateTime.now) }
  scope :deck, ->(current_deck_id) { expired.where(deck_id: current_deck_id) }


  def translation_correct?(user_text)
    if user_text.casecmp(original_text).zero?
      self.wrong_checks = 0
      self.correct_checks += 1
      plus_time
      self.save
      true
    else
      self.wrong_checks =+1
      wrong_checks_test
      self.save
      false
    end
  end

  private
    def wrong_checks_test
      if wrong_checks > 3
        self.correct_checks = 1
        wrong_checks = 0
      end
    end

    def plus_time
      self.correct_checks = 5 if self.correct_checks > 5
      period = TIMES.select { |key, value| key.to_i.eql? self.correct_checks }.values.first
      self.review_date = Date.today + period
    end
end
