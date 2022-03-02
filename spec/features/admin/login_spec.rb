require 'rails_helper'

RSpec.describe 'Вход в систему', driver: :selenium_chrome, js: true do
  context 'для пользователя администратора' do
    let (:admin_user) { create :admin_user }

    it 'администрирования происходит успешно' do
      visit new_user_session_path
      fill_in 'user_email', with: admin_user.email
      fill_in 'user_password', with: admin_user.password
      click_button 'commit'
      screenshot_and_save_page
      expect(current_path).to eq admin_dashboard_path
      expect(page).to have_content('Панель управления')
    end
  end

  context 'для обычного пользователя' do
    let (:user) { create :user }

    it 'происходит успешно' do
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'commit'
      expect(current_path).not_to eq admin_dashboard_path
      expect(page).not_to have_content('Панель управления')
    end

    it 'администрирования завершается неудачей' do
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'commit'
      visit admin_dashboard_path
      expect(current_path).to eq new_user_session_path
    end
  end
end
