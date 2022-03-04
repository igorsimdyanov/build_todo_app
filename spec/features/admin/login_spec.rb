require 'rails_helper'

RSpec.describe 'Вход в систему', driver: :selenium_chrome, js: true do
  before :each do
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'commit'    
  end

  context 'для пользователя администратора' do
    let(:user) { create :admin_user }

    it 'администрирования происходит успешно' do
      expect(page).to have_current_path admin_dashboard_path, ignore_query: true
      expect(page).to have_content('Панель управления')
    end
  end

  context 'для обычного пользователя' do
    let(:user) { create :user }

    it 'происходит успешно' do
      expect(page).to have_no_current_path admin_dashboard_path, ignore_query: true
      expect(page).not_to have_content('Панель управления')
    end

    it 'администрирования завершается неудачей' do
      visit admin_dashboard_path
      expect(page).to have_current_path new_user_session_path, ignore_query: true
    end
  end
end
