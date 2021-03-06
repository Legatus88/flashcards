require 'rails_helper'

describe 'checking translation' do 
    
  before(:each) do
    user_deck_card
    login('MyString', 'MyString')
  end

  context 'when translation is true' do
    before do 
      check_it('House') 
    end

    it "will tell Correct!" do
      expect(page).to have_content 'Правильно!'
    end
  end

  context 'when translation is false' do
    before { check_it('awda') }

    it "will tell Wrong!" do
      expect(page).to have_content 'Не правильно!'
    end
  end

  context 'when user created a card' do
    before { visit dashboard_cards_path }

    it 'will show user\'s card' do
      expect(page).to have_content 'House'
    end
  end

  context 'when another user logged in' do
    before do
      logout
      sing_in('3rd_user', '3rd_pass')
    end

    it 'will show nothing' do
      expect(page).to have_no_content 'House'
    end
  end  
end
