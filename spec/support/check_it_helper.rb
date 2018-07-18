def check_it(user_translation)
  visit root_path
  fill_in :user_text, with: user_translation
  click_button 'Check it!'
end

def sing_in(mail, pass)
  visit new_user_path
  fill_in :user_email, with: mail
  fill_in :user_password, with: pass
  fill_in :user_password_confirmation, with: pass
  click_button 'Create User'
end

def login(mail, pass)
  visit login_path
  fill_in :email, with: mail
  fill_in :password, with: pass
  click_button 'Login'
end

def logout
  visit 'user_sessions/destroy'
end

def twitter_login
  visit 'oauth/twitter'
end

def create_deck(title)
  visit new_deck_path
  fill_in :deck_title, with: title
  click_button 'Create Deck'
end

def choose_deck(id)
  visit switch_current_deck_path
  select id, from: :user_current_deck_id
  click_button 'Update User'
end

def user_deck_card
  @user = create(:user)
  @deck = create(:deck, user: @user)
  @card = create(:card, user: @user, deck: @deck)

  @card.update_attributes(review_date: Date.today - 4.day)
end
