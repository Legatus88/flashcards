class ApplicationController < ActionController::Base
  before_action :require_login, :set_locale

    def set_locale
      I18n.locale = params[:locale] || extract_locale_from_accept_language_header
    end

  private
    def not_authenticated
      redirect_to login_path, alert: "#{t('common.please_login')}"
    end

    def default_url_options
      { locale: I18n.locale }
    end

    def extract_locale_from_accept_language_header
      if request.env['HTTP_ACCEPT_LANGUAGE'].nil?
        I18n.default_locale 
      else
        request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
      end
    end
end
