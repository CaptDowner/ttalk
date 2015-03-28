require 'i18n'
class ApplicationController < ActionController::Base
  before_filter :set_locale
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def require_signin
    unless user_signed_in?
      session[:intended_url] = request.url
      redirect_to user_session_path, alert: "Please sign in!"
    end
  end

  def require_admin
    unless current_user && current_user.is_admin?
      redirect_to root_url, alert: "Unauthorized access!"
    end
  end

  # extract locale fom tld name
  def extract_locale_from_subdomain
    parsed_locale = ((request.original_url.split /\./)[0].split /\/\//)[1].to_sym
    I18n.available_locales.include?(parsed_locale) ? parsed_locale : nil
  end

  # set our locale to first part of tld name
  def set_locale
    I18n.locale = extract_locale_from_subdomain || I18n.default_locale
  end

end
