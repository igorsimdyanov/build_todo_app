require 'rails_helper'

RSpec.describe Event, type: :model do
  context 'в невалидном состоянии' do
    let(:event) { build(:event_wrong) }

    it 'когда пустое название' do
      expect(event.validate).to be_falsey
      error_message = 'Name обязательно для заполнения'
      expect(event.errors.full_messages).to include error_message
    end

    it 'когда отсутствует владелец' do
      expect(event.validate).to be_falsey
      error_message = 'User не может отсутствовать'
      expect(event.errors.full_messages).to include error_message
    end
  end

  context 'в валидном состоянии' do
    let(:event) { create(:event) }

    it 'удовлетворяет валидациям' do
      expect(event).to be_valid
    end
  end
end
