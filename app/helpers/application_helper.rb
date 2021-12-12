# frozen_string_literal: true

module ApplicationHelper
  def current_user_avatar?
    user_signed_in? && current_user.avatar.attached?
  end

  def current_date
    Date.current.to_s
  end

  def language_link_name
    session[:locale] == I18n.default_locale.to_s ? 'EN' : 'RU'
  end
end
