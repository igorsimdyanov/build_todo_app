# == Schema Information
#
# Table name: items
#
#  id                                                 :bigint           not null, primary key
#  done(Статус: завершено (true), или нет (false))    :boolean          default(FALSE)
#  finished_at(Дата и время завершения подпункта)     :datetime
#  name(Заголовок)                                    :string
#  created_at                                         :datetime         not null
#  updated_at                                         :datetime         not null
#  event_id(Внешний ключ для связи с таблицей events) :bigint
#
# Indexes
#
#  index_items_on_event_id  (event_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_id => events.id)
#
class Item < ApplicationRecord
  belongs_to :event
end
