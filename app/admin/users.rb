ActiveAdmin.register User do
  menu priority: 1, label: 'Пользователи'
  permit_params :email, :name, :active, :role_id, :password, :password_confirmation
  actions :all, except: [:update, :destroy]
  config.sort_order = 'name'

  index do
    selectable_column
    id_column
    column :email
    column :name
    column :active
    column :role
    actions
  end

  controller do
    def csv_filename
      'csv_report.csv'
    end
  end

  csv do
    column :id
    column :name
    column('Электронная почта', &:email)
    column('Роль') { |user| user.role.code }
  end

  filter :email
  filter :name
  filter :active
  filter :role

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :email
      f.input :name
      f.input :active
      f.input :role
      if f.object.new_record?
        f.input :password
        f.input :password_confirmation
      end
    end
    f.actions do
      f.action :submit, label: 'Отправить', as: :button
    end
  end
end
