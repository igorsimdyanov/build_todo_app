# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AboutController, type: :controller do
  describe 'GET index' do
    it 'возвращает успешный ответ' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
