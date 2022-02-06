# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # protect_from_forgery unless: -> { request.format.json? }
  # protect_from_forgery prepend: true
  include Pundit
  before_action :configure_permitted_parameters, if: :devise_controller?

  def access_denied(_exception)
    sign_out
    redirect_to root_path
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name email avatar])
  end

  def after_sign_in_path_for(user)
    user.admin? ? admin_dashboard_path : root_path
  end
end
