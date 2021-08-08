require 'doctors/parameter_sanitizer'
require 'patients/parameter_sanitizer'

class ApplicationController < ActionController::Base
  before_filter :devise_parameter_sanitizer, if: :devise_controller?
  protect_from_forgery with: :exception

  protected

  def devise_parameter_sanitizer
    if resource_class == Doctor
      Doctor::ParameterSanitizer.new(Doctor, :doctor, params)
    elsif resource_class == Patient
      Patient::ParameterSanitizer.new(Patient, :patient, params)
    else
      super # Use the default one
    end
  end
end
