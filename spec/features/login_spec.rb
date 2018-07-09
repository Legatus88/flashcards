require 'rails_helper'

describe 'checking translation' do 
  let!(:card) { create(:card) }
    
  before(:each) do
    card.update_attributes(review_date: Date.today - 4.day)
    sing_in('new_mail', 'pass')
    logout
  end

  context 'when user is not logged in' do
    before { visit root_path }

    it 'get login form' do
      expect(page).to have_content 'Please login first'
    end
  end

  context 'when user is logged in' do
    before { login('new_mail', 'pass') }

    it 'give offer a card' do
      expect(page).to have_content 'Translate this word:'
    end
  end

  context 'when login is wrong' do
    before { login('old_mail', 'old_pass') }
    
    it 'will not login the user' do
      expect(page).to have_content 'Login failed'
    end
  end

  context 'when login is correct' do
    before { login('new_mail', 'pass') }
    
    it 'will login the user' do
      expect(page).to have_content 'Login successful'
    end
  end
end

