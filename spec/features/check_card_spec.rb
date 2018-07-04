require 'rails_helper'

describe 'checking translation' do 
  let!(:user) { create(:user) }
  let!(:card) { create(:card) }
    
  before(:each) do
    card.update_attributes(review_date: Date.today - 4.day)
  end

  context 'when translation is true' do
    before { check_it('House') }

    it "will tell Correct!" do
      expect(page).to have_content 'Correct!'
    end
  end

  context 'when translation is false' do
    before { check_it('awda') }

    it "will tell Wrong!" do
      expect(page).to have_content 'Wrong!'
    end
  end
end
