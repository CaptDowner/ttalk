require 'i18n'
class ApplicationController < ActionController::Base
  before_filter :set_locale
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def require_signin
    unless current_user
      session[:intended_url] = request.url
      redirect_to new_session_url, alert: "Please sign in!"
    end
  end

  def require_admin
    unless current_user_admin?
      redirect_to root_url, alert: "Unauthorized access!"
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

  def current_user?(user)
    current_user == user
  end

  helper_method :current_user?

  def current_user_admin?  
    current_user && current_user.is_admin?
  end

  helper_method :current_user_admin?

  def current_user_or_admin?
    current_user || current_user.is_admin?
  end

  helper_method :current_user_or_admin?

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
