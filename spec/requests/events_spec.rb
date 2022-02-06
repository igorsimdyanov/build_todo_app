require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe 'GET /' do
    it 'возвращает успешный ответ' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
