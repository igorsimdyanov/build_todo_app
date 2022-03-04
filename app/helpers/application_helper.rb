# frozen_string_literal: true

module ApplicationHelper
  def current_user_avatar?
    user_signed_in? && current_user.avatar.attached?
  end

  def current_date
    Date.current.to_s
  end

  def language_link_name
    locale == I18n.default_locale.to_s ? 'EN' : 'RU'
  end

  def locale
    lang = session.fetch(:locale, I18n.default_locale.to_s)
    lang = I18n.default_locale.to_s unless I18n.available_locales.map(&:to_s).include? lang
    lang
  end
end
