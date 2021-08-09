
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  rescue_from CanCan::AccessDenied do
    flash[:error] = 'Access denied!'
    redirect_to root_url
  end

  def current_ability
    @current_ability ||= ::Ability.new((doctor_signed_in?) ? current_doctor : current_patient)
  end

  protected

end
