require "rails_helper"

RSpec.describe Card, :type => :model do 
  let(:test_card) { Card.new(original_text: 'Home', translated_text: 'Дом', review_date: Date.today) }

  describe 'validations' do
  	it 'should be not valid' do
  	  card = Card.new(original_text: 'дом', translated_text: ' дом')
  	  expect(card.valid?).to be false
  	  expect(card.errors[:difference].any?).to be true
	end

	it 'should be not valid' do
	  card = Card.new(original_text: '', translated_text: '')
  	  expect(card.valid?).to be false
  	  expect(card.errors[:empty_fields].any?).to be true
	end

	it 'should be not valid' do
	  card = Card.new(original_text: 'Home', translated_text: 'Дом')
  	  expect(card.valid?).to be false
  	  expect(card.errors[:difference].any?).to be false
	end

	it 'should be valid' do
	  card = Card.new(original_text: 'Home', translated_text: 'Дом', review_date: Date.today)
  	  expect(card.valid?).to be true
  	  expect(card.errors[:difference].any?).to be false
  	  expect(card.errors[:empty_fields].any?).to be false
	end
  end

  describe '.translation_correct?' do 
  	before { test_card }


  	it 'should be not right' do
      expect(test_card.translation_correct?('battlestart')).to be false
  	end

  	it 'should be correct' do 
      expect(test_card.translation_correct?('Home')).to be true
      expecting_date = Date.today + 3.day
      expect(test_card.review_date.to_s).to eq(expecting_date.to_s)
  	end

  end

end





