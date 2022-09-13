class ApplicationController < ActionController::Base
  before_action :set_locale
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def set_locale
    if params[:locale] && I18n.available_locales.include?( params[:locale].to_sym )
      session[:locale] = params[:locale]
    end

    I18n.locale = session[:locale] || I18n.default_locale
  end

  private

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore
    flash[:alert] = t "#{policy_name}.#{exception.query}", scope: 'pundit', default: :default,
                      username: exception.policy.record.try(:user).try(:email)
    redirect_to(request.referrer || root_path)
  end
  def pundit_user
    current_user
  end
end
