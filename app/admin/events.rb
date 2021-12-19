ActiveAdmin.register Event do
  menu priority: 2

  index do
    id_column
    column 'Содержимое' do |event|
      tag.strong(event.name.truncate(50)) +
      tag.br +
      event.name.truncate(50)
    end
    column :done
    column :user
    actions
  end

  filter :id
  filter :name
  filter :content
  filter :done
  filter :finished_at

  show title: proc { |event| event.name.truncate(50) } do
    attributes_table do
      row :id
      row :name
      row :content
      row :done
      row :user
      row :finished_at
      row :updated_at
      row :created_at
    end

    panel 'Подпункты' do
      scope = resource.items.order(created_at: :desc)
      table_for scope do
        column 'ID', :id
        column 'Название', :time
        column 'Выполнено', :done
        column 'Срок выполнения', :finished_at
        column 'Дата обновления', :updated_at
        column 'Дата создания', :created_at
      end
    end
  end
end

    # panel 'Сообщения' do
    #   scope = resource.rabbit_messages.order(created_at: :desc)
    #   table_for scope do
    #     column 'ID', :id
    #     column 'Action', :action
    #     column 'Routing Key', :routing_key
    #     column 'Direction', :direction
    #     column 'Success', :success
    #     column 'Дата отправки', :created_at
    #     column do |message|
    #       tag.a 'Открыть', href: admin_rabbit_message_path(message)
    #     end
    #   end
    # end
