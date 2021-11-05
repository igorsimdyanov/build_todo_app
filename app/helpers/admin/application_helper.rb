module Admin::ApplicationHelper
  def action_title(klass, action_name)
    action_case = action_name == 'index' ? 'many' : 'accusative'

    [
      t("label.#{action_name}"),
      t("activerecord.models.#{klass.name.tableize.singularize}.#{action_case}")
    ].join(' ')
  end

  def activate_title(user)
    user.active? ? 'Disactivate' : 'Activate'
  end
end
