class ApplicationController < ActionController::Base
  before_action :set_locale
  def is_admin?
    # check if user is a admin
    # if not admin then redirect to where ever you want
    redirect_to root_path unless current_user.admin?
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def set_locale
    I18n.locale = extract_locale || I18n.default_locale
  end

  def extract_locale
    parsed_locale = params[:locale]
    return unless I18n.available_locales.map(&:to_s).include?(parsed_locale)

    parsed_locale.to_sym
  end
  
  def favourite_text
    return @favourite_exists ? (t "add_unfavourite") : (t "add_favourite")
  end

  helper_method :favourite_text
end
