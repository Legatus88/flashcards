class ApplicationController < ActionController::Base
  before_action :require_login, :set_locale

    def set_locale
      logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
      #I18n.locale = params[:locale] || I18n.default_locale
      I18n.locale = params[:locale] || extract_locale_from_accept_language_header
      logger.debug "* Locale set to '#{I18n.locale}'"
    end

  private
    def not_authenticated
      redirect_to login_path, alert: "#{t('common.please_login')}"
    end

    def default_url_options
      { locale: I18n.locale }
    end

    def extract_locale_from_accept_language_header
      request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    end
end
