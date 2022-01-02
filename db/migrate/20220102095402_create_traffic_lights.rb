class CreateTrafficLights < ActiveRecord::Migration[6.1]
  def change
    create_table :traffic_lights, comment: 'Светофоры города' do |t|
      t.string :address, comment: 'Адрес установки светофора'

      t.timestamps
    end
  end
end
