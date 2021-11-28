# frozen_string_literal: true

class AddEventsCountToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :events_count, :integer
  end
end
