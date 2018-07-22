require 'rails_helper'

RSpec.describe Card, type: :model do
  let(:test_card) { Card.new(original_text: 'Home', translated_text: 'Дом', review_date: Date.today) }
  let(:expecting_date_1) { Date.today + 0.5.day }
  let(:expecting_date_2) { Date.today + 3.day }
  let(:expecting_date_3) { Date.today + 7.day }
  let(:expecting_date_4) { Date.today + 14.day }
  let(:expecting_date_5) { Date.today + 1.months }

  describe '.translation_correct?' do
    before { test_card }

    it 'should be not right' do
      expect(test_card.translation_correct?('battlestart')).to be false
    end

    it 'should be correct' do
      expect(test_card.translation_correct?('Home')).to be true
    end
  end

  describe 'changing review_date' do
    it 'should change review_date by 0.5 days' do
      test_card.translation_correct?('Home')
      expect(test_card.review_date.to_s).to eq(expecting_date_1.to_s)
    end

    it 'should change review_date by 3 days' do
      2.times { test_card.translation_correct?('Home') }
      expect(test_card.review_date.to_s).to eq(expecting_date_2.to_s)
    end

    it 'should change review_date by 7 days' do
      3.times { test_card.translation_correct?('Home') }
      expect(test_card.review_date.to_s).to eq(expecting_date_3.to_s)
    end

    it 'should change review_date by 14 days' do
      4.times { test_card.translation_correct?('Home') }
      expect(test_card.review_date.to_s).to eq(expecting_date_4.to_s)
    end

    it 'should change review_date by 1 month' do
      5.times { test_card.translation_correct?('Home') }
      expect(test_card.review_date.to_s).to eq(expecting_date_5.to_s)
    end

    it 'should change review_date by 1 month' do
      6.times { test_card.translation_correct?('Home') }
      expect(test_card.review_date.to_s).to eq(expecting_date_5.to_s)
    end

    it 'should change review_date to 12 hours' do
      4.times { test_card.translation_correct?('NotHome') }
      expect(test_card.review_date.to_s).to eq(expecting_date_1.to_s)
    end
  end
end
