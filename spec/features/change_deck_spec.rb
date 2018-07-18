require 'rails_helper'

describe 'checking translation' do 
    
  before(:each) do
    user_deck_card
    login("MyString", "MyString")
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
      expect(page).to have_content 'No cards needed'
    end
  end
end