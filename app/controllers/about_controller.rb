# frozen_string_literal: true

class AboutController < ApplicationController
  before_action :log_start, :log_params, :log_finish, only: :index

  def index
    session[:about_counter] ||= 0
    session[:about_counter] += 1
    I18n.locale = session.fetch(:locale, I18n.default_locale).to_sym
  end

  private

  def log_start
    Rails.logger.info '#########################################'
  end

  alias log_finish log_start

  def log_params
    Rails.logger.info params.inspect
  end
end
