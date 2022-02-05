# == Schema Information
#
# Table name: events
#
#  id          :bigint           not null, primary key
#  content     :text
#  done        :boolean          default(FALSE)
#  finished_at :datetime
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint
#
# Indexes
#
#  index_events_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
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

  context 'belongs_to связь' do
    let(:event) { create(:event) }
    let(:user) { create(:user) }

    it 'успешно работает' do
      expect(event).to respond_to(:user)
      expect(event.user).to be_instance_of(User)
    end

    it 'успешно увеличивает счетчик в таблице users' do
      expect {
        user.events.create(attributes_for(:event))
      }.to change { user.events_count }.by 1
    end
  end
end
