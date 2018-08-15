require 'rails_helper'

describe 'changing current deck' do 
    
  before(:each) do
    user_deck_card
    login("MyString", "MyString")
  end
  
  context 'when current deck doesn\'t selected' do
    before { visit dashboard_decks_path }

    it 'will show no deck' do
      expect(page).to have_content 'Колода не выбрана'
    end
  end

  context 'when deck with a card is selected' do 
    before do 
      choose_deck('first_deck')
      visit root_path
    end

    it 'will show his card' do
      expect(page).to have_content 'Дом' 
    end
  end

  context 'when user create a card on his deck' do
    before { visit root_path }
    
    it 'will show his card' do
      expect(page).to have_content 'Дом' 
    end
  end

  context 'when user create a card on another deck' do
    before do
      create_deck('second_deck')
      choose_deck('second_deck')
      visit root_path
    end

    it 'will show \'No cards needed\'' do
      expect(page).to have_content 'Нужные карточки отсутствуют'
    end
  end
end