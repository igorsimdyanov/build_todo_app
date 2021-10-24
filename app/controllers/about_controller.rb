class AboutController < ApplicationController
  before_action :log_start, :log_params, :log_finish, only: :index

  def index; end

  private

  def log_start
    Rails.logger.info '#########################################'
  end

  alias log_finish log_start

  def log_params
    Rails.logger.info params.inspect
  end
end
