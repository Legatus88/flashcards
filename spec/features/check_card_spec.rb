require 'rails_helper'

describe 'checking translation' do 
  let!(:card) { create(:card) }

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
