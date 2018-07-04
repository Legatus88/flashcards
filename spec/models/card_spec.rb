require 'rails_helper'

RSpec.describe Card, type: :model do
  let(:test_card) { Card.new(original_text: 'Home', translated_text: 'Дом', review_date: Date.today) }
  let(:expecting_date) { Date.today + 3.day }

  describe '.translation_correct?' do
    before { test_card }

    it 'should be not right' do
      expect(test_card.translation_correct?('battlestart')).to be false
    end

    it 'should be correct' do
      expect(test_card.translation_correct?('Home')).to be true
    end

    it 'should change review_date by 3 days' do
      test_card.translation_correct?('Home')
      expect(test_card.review_date.to_s).to eq(expecting_date.to_s)
    end
  end
end
