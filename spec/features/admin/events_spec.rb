require 'rails_helper'

RSpec.describe Admin::EventsController, driver: :selenium_chrome, js: true do
  let(:user) { create :admin_user }
  before :each do
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'commit'
  end

  context 'индексная страница' do
    it 'успешный переход' do
      visit admin_events_path
      expect(page).to have_content('События')
    end

    it 'успешно отражает новое событие' do
      create(:event, name: 'Тестовое событие')
      visit admin_events_path
      expect(page).to have_content('Тестовое событие')
    end
  end

  context 'детальная страница' do
    let(:event) { create(:event, name: 'Тестовое событие') }

    it 'детальная страница' do
      visit admin_event_path(event)
      expect(page).to have_current_path admin_event_path(event), ignore_query: true
      expect(page).to have_content('Тестовое событие')
    end
  end
end
