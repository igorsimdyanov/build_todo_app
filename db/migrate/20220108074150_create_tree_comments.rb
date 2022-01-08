class CreateTreeComments < ActiveRecord::Migration[6.1]
  def change
    create_table :tree_comments, comment: 'Таблица замыканий для комментариев' do |t|
      t.integer :parent_id, comment: 'Внешний ключ для родительского комментария'
      t.integer :child_id, comment: 'Внешний ключ для ответа'

      t.timestamps

      t.index [:parent_id, :child_id], unique: true
    end
  end
end
