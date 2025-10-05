class ApplicationController < ActionController::API
  before_action :set_locale

  private
  def set_locale
    locale = params[:locale] || request.headers["locale"] || request.headers["Accept-Language"]
    I18n.locale = locale || I18n.default_locale
  end
end
