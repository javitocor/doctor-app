require 'rails_helper'
require 'capybara/rspec'

RSpec.describe PatientsController, type: :feature do
  context 'GET patient controller views' do
    let(:doctor) { Doctor.create({ name: 'Sally', email: 'sally@example.com', password: 'aaaaaaaa', password_confirmation: 'aaaaaaaa', DOB: Date.new(1980, 9, 17), graduated: 2001, city: 'Barcelona', resume:'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris posuere ante eget lacus ultricies, et laoreet nunc scelerisque. Curabitur vulputate suscipit pellentesque. Nunc molestie purus nisl, eu porttitor lorem pretium a. Duis sagittis, dui id lobortis gravida, quam diam placerat magna, lobortis tempor odio erat vitae felis. Nulla venenatis est lorem. Suspendisse dapibus ante odio, vel consectetur diam rhoncus varius. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nullam vitae porta metus. Mauris porta at massa quis iaculis. Aenean et blandit tellus. Donec pellentesque ipsum metus.' }) }
    let(:patient) { Patient.create({ name: 'John', surname: 'Wilkins', email: 'john@example.com', password: 'aaaaaaaa', password_confirmation: 'aaaaaaaa', DOB: Date.new(1965, 9, 11), city: 'Montpellier', medical_history:'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris posuere ante eget lacus ultricies, et laoreet nunc scelerisque. Curabitur vulputate suscipit pellentesque. Nunc molestie purus nisl, eu porttitor lorem pretium a. Duis sagittis, dui id lobortis gravida, quam diam placerat magna, lobortis tempor odio erat vitae felis. Nulla venenatis est lorem. Suspendisse dapibus ante odio, vel consectetur diam rhoncus varius. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nullam vitae porta metus. Mauris porta at massa quis iaculis. Aenean et blandit tellus. Donec pellentesque ipsum metus.' }) }
    let(:appointment) {Appointment.create(id: 1, subject: 'Anual checking', starts_at: Time.zone.now, ends_at: Time.zone.now + 2.hours, doctor_id: doctor.id, patient_id:patient.id)}
    
    it 'Get #index as patient' do
      visit new_patient_session_path
      fill_in 'patient_email', with: patient.email
      fill_in 'patient_password', with: patient.password
      click_button 'Log in'
      visit patients_path
      expect(page).to have_content('Patients')
    end
    it 'Get #show action of a patient as patient' do
      visit new_patient_session_path
      fill_in 'patient_email', with: patient.email
      fill_in 'patient_password', with: patient.password
      click_button 'Log in'
      visit patient_path(patient)
      expect(page).to have_content(patient.name.to_s)
    end
    it 'Get #show of a patient as doctor' do
      visit new_doctor_session_path
      fill_in 'doctor_email', with: doctor.email
      fill_in 'doctor_password', with: doctor.password
      click_button 'Log in'
      visit patient_path(patient)
      expect(page).to have_content(patient.name.to_s)
    end
  end
end