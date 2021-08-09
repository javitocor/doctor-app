class Doctor::ParameterSanitizer < Devise::ParameterSanitizer
  def initialize(*)
    super
    permit(:sign_up, keys: [:name, :graduated, :DOB, :city, :resume])
    permit(:account_update, keys: [:name, :graduated, :DOB, :city, :resume])
  end
end