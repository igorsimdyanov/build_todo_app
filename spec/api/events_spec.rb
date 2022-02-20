require 'rails_helper'

describe Events, type: :api do
  before do
    create(:event)
    create(:event, done: true)
  end

  let(:event_json) {
    include(
      'id' => a_value > 0,
      'name' => be_an(String),
      'content' => be_an(String),
      'done' => eq(true) | eq(false),
      'user' => hash_including(
        'id' => a_value > 0,
        'name' => a_kind_of(String),
        'role' => a_kind_of(String)
      )
    )    
  }

  describe 'GET /api/events' do
    it 'успешно отвечает' do
      get '/api/events'
      expect(last_response.status).to eq(200)
    end

    it 'содержит единственное событие' do
      get '/api/events'
      expect(json_dig('events').count).to eq(1)
    end

    it 'с параметром all выводятся все события' do
      get '/api/events?all=true'
      expect(json_dig('events').count).to eq(2)
    end

    it 'отдает правильную структуру' do
      get '/api/events'
      expect(json_dig('events')).to include(event_json)
    end
  end
end
