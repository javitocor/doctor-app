class Appointment < ApplicationRecord
  validates :subject, presence: true, length: { maximum: 50, too_long: '50 characters in subject is the maximum allowed.'  }
  validates :starts_at, presence: true
  validates :ends_at, presence: true
  validate :valid_date
  
  belongs_to :doctor
  belongs_to :patient

  mount_uploaders :patient_images, PatientImagesUploader

  def valid_date
    errors.add(:starts_at, "Can't book in the past") if starts_at.present? && starts_at < Date.current
  end

  def self.find_in_appointments(role, id)
    if role == 'Patient'
      where(patient_id: id)
    elsif role == 'Doctor'
      where(doctor_id: id)
    end
  end
end
