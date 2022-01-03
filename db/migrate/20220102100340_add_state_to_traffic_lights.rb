class AddStateToTrafficLights < ActiveRecord::Migration[6.1]
  def change
    add_column :traffic_lights, :state, :string
  end
end
