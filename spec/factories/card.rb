FactoryBot.define do
  factory :card do
    original_text 'House'
    translated_text 'Дом'
    review_date Date.today
    deck_id '1'
  end
end