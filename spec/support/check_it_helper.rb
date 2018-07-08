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