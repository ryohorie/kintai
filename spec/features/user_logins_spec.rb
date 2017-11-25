require 'rails_helper'

RSpec.feature "UserLogins", type: :feature do

  given(:user) { create(:user) }

  feature 'user logs in' do

    scenario 'login with valid information followed by logout' do
      visit login_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: 'password'
      click_button 'ログイン'
      expect(page).to have_current_path root_path

      click_on 'ログアウト'
      expect(page).to have_current_path login_path
    end
  end
end
