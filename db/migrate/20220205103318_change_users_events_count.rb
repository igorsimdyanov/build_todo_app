class ChangeUsersEventsCount < ActiveRecord::Migration[6.1]
  def change
    change_column :users,
                  :events_count,
                  :integer,
                  comment: 'Счетчик событий пользователя (belongs_to)',
                  default: 0
  end
end
