def check_it(user_translation)
  visit root_path
  fill_in :user_text, with: user_translation
  click_button 'Check it!'
end
