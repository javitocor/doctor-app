class Doctor < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true
  validates :DOB, presence: true
  validates :name, presence: true, length: { maximum: 45, too_long: '45 characters in doctor name is the maximum allowed.'  }
  validates :city, presence: true
  validates :graduated, presence: true
  validates :resume, presence: true

  has_many :appointments

  def self.search(search)  
    where("lower(doctors.name) LIKE :search OR  lower(doctors.city) LIKE :search", search: "%#{search.downcase}%") 
  end
end
