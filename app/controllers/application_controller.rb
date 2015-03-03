require 'i18n'
class ApplicationController < ActionController::Base
  before_filter :set_locale
#  before_action :set_locale
  include LocaleDetection

  private

  # extract locale fom tld name
  def extract_locale_from_subdomain
    parsed_locale = ((request.original_url.split /\./)[0].split /\/\//)[1].to_sym
#    binding.pry
    I18n.available_locales.include?(parsed_locale) ? parsed_locale : nil
  end

  # set our locale to first part of tld name
  def set_locale
    I18n.locale = extract_locale_from_subdomain || I18n.default_locale
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:sign_up) << :email
    devise_parameter_sanitizer.for(:sign_up) << :password
    devise_parameter_sanitizer.for(:sign_up) << :password_confirmation
  end
end
