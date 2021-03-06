require 'rails_helper'

describe 'checking translation' do 
    
  before(:each) do
    user_deck_card
    sing_in('new_mail', 'pass')
    logout
  end

  context 'when user is not logged in' do
    before { visit root_path }

    it 'get login form' do
      expect(page).to have_content 'Авторизуйтесь'
    end
  end

  context 'when user is logged in' do
    before { login('MyString', 'MyString') }

    it 'give offer a card' do
      expect(page).to have_content 'Переведите это слово:'
    end
  end

  context 'when login is wrong' do
    before { login('old_mail', 'old_pass') }
    
    it 'will not login the user' do
      expect(page).to have_content 'Авторизация провалена'
    end
  end

  context 'when login is correct' do
    before { login('new_mail', 'pass') }
    
    it 'will login the user' do
      expect(page).to have_content 'Авторизация успешна'
    end
  end
end

