module Accessible
  extend ActiveSupport::Concern
  included do
    before_action :check_resource
  end

  protected

  def check_resource
    if doctor_signed_in?
      flash.clear
      redirect_to(doctors_authenticated_root_path) and return
    elsif patient_signed_in?
      flash.clear
      redirect_to(patients_authenticated_root_path) and return
    end
  end
end