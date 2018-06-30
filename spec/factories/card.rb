FactoryBot.define do
  after(:create) do |card| 
      card.update_attributes(review_date: Date.today - 4.day)
  end

  factory :card do
    original_text 'House'
    translated_text 'Дом'
    review_date Date.today
  end

end