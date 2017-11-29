require 'rails_helper'

RSpec.feature "UserSignups", type: :feature do

  scenario 'with invalid signup information' do
    visit signup_path
    fill_in 'お名前', with: ''
    fill_in 'メールアドレス', with: 'user@invalid'
    fill_in 'パスワード', with: 'foo'
    fill_in 'パスワード（確認用）', with: 'bar'
    click_on '登録'

    expect(page).to have_current_path users_path
    expect(page).to have_selector 'div#error_explanation'
    expect(page).to have_selector 'div.alert'
  end

  scenario 'with valid signup information' do
    visit signup_path
    fill_in 'お名前', with: 'Example User"'
    fill_in 'メールアドレス', with: 'example_user@example.com'
    fill_in 'パスワード', with: 'password'
    fill_in 'パスワード（確認用）', with: 'password'
    click_on '登録'

    expect(page).to have_current_path login_path
  end
end
