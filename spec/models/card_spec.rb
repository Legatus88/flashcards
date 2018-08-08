require 'rails_helper'

RSpec.describe SuperMemo, type: :model do
  let(:test_card) { Card.new(original_text: 'Home', translated_text: 'Дом', review_date: Date.today) }
  let(:expecting_date_1) { Date.today + 1.day }
  let(:expecting_date_2) { Date.today + 6.day }

  describe '.translation_correct?' do
    it 'should be not right' do
      expect(SuperMemo.new(test_card).translation_correct?('battlestart', '3')).to be false
    end

    it 'should be correct' do
      expect(SuperMemo.new(test_card).translation_correct?('Home', '3')).to be true
    end
  end

  describe 'changing review_date' do
    it 'should change review_date by 1 day' do
      SuperMemo.new(test_card).translation_correct?('Home', '3')
      expect(test_card.review_date.to_s).to eq(expecting_date_1.to_s)
    end

    it 'should change review_date by 6 days' do
      2.times { SuperMemo.new(test_card).translation_correct?('Home', '3') }
      expect(test_card.review_date.to_s).to eq(expecting_date_2.to_s)
    end
  end
  
  describe 'changing quality' do
    it 'should change quality to 5' do
      SuperMemo.new(test_card).translation_correct?('Home', '3')
      expect(test_card.quality).to eq(5)
    end

    it 'should change quality to 4' do
      SuperMemo.new(test_card).translation_correct?('Home', '5')
      expect(test_card.quality).to eq(4)
    end

    it 'should change quality to 3' do
      SuperMemo.new(test_card).translation_correct?('Home', '8')
      expect(test_card.quality).to eq(3)
    end

    it 'should change quality to 2' do
      SuperMemo.new(test_card).translation_correct?('Home', '20')
      expect(test_card.quality).to eq(2)
    end

    it 'should change quality to 1' do
      SuperMemo.new(test_card).translation_correct?('Home', '30')
      expect(test_card.quality).to eq(1)
    end

    it 'should change quality to 0' do
      SuperMemo.new(test_card).translation_correct?('Home', '100')
      expect(test_card.quality).to eq(0)
    end
  end

  describe 'changing e_factor' do
    it 'should be 2.5 by default' do
      expect(test_card.e_factor).to eq(2.5)
    end

    it 'should be 2.6' do
      SuperMemo.new(test_card).translation_correct?('Home', '3')
      expect(test_card.e_factor).to eq(2.6)
    end

    it 'should be 2.5' do
      SuperMemo.new(test_card).translation_correct?('Home', '5')
      expect(test_card.e_factor).to eq(2.5)
    end

    it 'should be 2.36' do
      SuperMemo.new(test_card).translation_correct?('Home', '10')
      expect(test_card.e_factor).to eq(2.36)
    end

    it 'should be 2.5' do
      SuperMemo.new(test_card).translation_correct?('Home', '20')
      expect(test_card.e_factor).to eq(2.5)
    end
  end

  describe 'changing step_number and last_term' do 
    before { 2.times { SuperMemo.new(test_card).translation_correct?('Home', '5') } } 
    
    it 'should be 1' do 
      expect(test_card.step_number).to eq(2)
    end

    it 'should be 1' do 
      expect(test_card.last_term).to eq(6)
    end
  end
end
