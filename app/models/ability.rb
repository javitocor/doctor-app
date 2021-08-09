class Ability
  include CanCan::Ability

  def initialize(user)
    if user.class.name == 'Doctor'
      can :read, Patient
      can :read, Appointment
      can :destroy, Appointment do |appointment|
        appointment.try(:doctor) == user
      end
    elsif user.class.name == 'Patient'
      can :read, Doctor
      can :read, Appointment
      can :create, Appointment
      can :edit, Appointment
      can :update, Appointment do |appointment|
        appointment.try(:patient) == user
      end
      can :destroy, Appointment do |appointment|
        appointment.try(:patient) == user
      end
    else
      cannot :manage, :all
    end
  end
end