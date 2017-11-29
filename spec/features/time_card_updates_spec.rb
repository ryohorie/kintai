require 'rails_helper'

RSpec.feature "TimeCardUpdates", type: :feature, js: true do

  given(:user) { create(:user) }
  
  background do
    login
  end

  scenario 'user comes into office' do
    expect(page).to have_current_path root_path    
    expect(page).to have_css '#work-status', text: '未出社'

    click_on '出社'
    
    expect(page).to have_css '#work-status', text: '勤務中'
  end

  def login
    visit login_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
  end
end
