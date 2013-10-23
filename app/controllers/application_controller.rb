class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # this is needed to avoid devise breaking on email param
  before_filter :configure_permitted_parameters, if: :devise_controller?

  around_filter :with_locale

  protected

  PERMITTED_USER_FIELDS = [:name, :username, :email, :password, :password_confirmation, :language, :gender, :login, :remember_me, :birthday]
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) do |u| u.permit PERMITTED_USER_FIELDS end
    devise_parameter_sanitizer.for(:sign_up) do |u| u.permit PERMITTED_USER_FIELDS end
    devise_parameter_sanitizer.for(:sign_in) do |u| u.permit PERMITTED_USER_FIELDS end
  end

  def with_locale
    old_locale = I18n.locale
    begin
      if current_user
        I18n.locale = current_user.locale
      end
      yield
    ensure
      I18n.locale = old_locale
    end
  end
end
