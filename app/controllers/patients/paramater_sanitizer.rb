class Patient::ParameterSanitizer < Devise::ParameterSanitizer
  def initialize(*)
    super
    permit(:sign_up, keys: [:name, :surname, :DOB, :city, :medical_history])
    permit(:account_update, keys: [:name, :surname, :DOB, :city, :medical_history])
  end
end