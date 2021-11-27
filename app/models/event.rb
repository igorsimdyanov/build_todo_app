# == Schema Information
#
# Table name: events
#
#  id                                               :bigint           not null, primary key
#  content(Детальное описание)                      :text
#  done(Статус: завершено (true), или нет (false))  :boolean          default(FALSE)
#  finished_at(Дата и время завершения дела)        :datetime
#  name(Заголовок)                                  :string
#  created_at                                       :datetime         not null
#  updated_at                                       :datetime         not null
#  user_id(Внешний ключ для связи с таблицей users) :bigint
#
# Indexes
#
#  index_events_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Event < ApplicationRecord
  belongs_to :user, counter_cache: true
  has_many :items, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :commentators, through: :comments, source: :user
end
