class Appointment < ApplicationRecord
  validates :subject, presence: true, length: { maximum: 50, too_long: '50 characters in subject is the maximum allowed.'  }
  validates :starts_at, presence: true
  validates :ends_at, presence: true
  validate :valid_date
  
  belongs_to :doctor
  belongs_to :patient

  def valid_date
    errors.add(:starts_at, "Can't book in the past") if starts_at.present? && starts_at < Date.current
  end
end
