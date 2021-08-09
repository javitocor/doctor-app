class Patient < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true
  validates :DOB, presence: true
  validates :name, presence: true, length: { maximum: 45, too_long: '45 characters in patient name is the maximum allowed.'  }
  validates :surname, presence: true, length: { maximum: 45, too_long: '45 characters in patient surname is the maximum allowed.'  }
  validates :city, presence: true
  validates :medical_history, presence: true
  
  has_many :appointments
end
