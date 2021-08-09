require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'Login and signup features', type: :feature do
  context 'login and logout' do
    let(:doctor) { Doctor.create({ name: 'Sally', email: 'sally@example.com', password: 'aaaaaaaa', password_confirmation: 'aaaaaaaa', DOB: Date.new(1980, 9, 17), graduated: 2001, city: 'Barcelona', resume:'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris posuere ante eget lacus ultricies, et laoreet nunc scelerisque. Curabitur vulputate suscipit pellentesque. Nunc molestie purus nisl, eu porttitor lorem pretium a. Duis sagittis, dui id lobortis gravida, quam diam placerat magna, lobortis tempor odio erat vitae felis. Nulla venenatis est lorem. Suspendisse dapibus ante odio, vel consectetur diam rhoncus varius. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nullam vitae porta metus. Mauris porta at massa quis iaculis. Aenean et blandit tellus. Donec pellentesque ipsum metus.' }) }
    let(:patient) { Patient.create({ name: 'John', surname: 'Wilkins', email: 'john@example.com', password: 'aaaaaaaa', password_confirmation: 'aaaaaaaa', DOB: Date.new(1965, 9, 11), city: 'Montpellier', medical_history:'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris posuere ante eget lacus ultricies, et laoreet nunc scelerisque. Curabitur vulputate suscipit pellentesque. Nunc molestie purus nisl, eu porttitor lorem pretium a. Duis sagittis, dui id lobortis gravida, quam diam placerat magna, lobortis tempor odio erat vitae felis. Nulla venenatis est lorem. Suspendisse dapibus ante odio, vel consectetur diam rhoncus varius. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nullam vitae porta metus. Mauris porta at massa quis iaculis. Aenean et blandit tellus. Donec pellentesque ipsum metus.' }) }
    let(:appointment) {Appointment.create(id: 1, subject: 'Anual checking', start_at: Time.zone.now, end_at: Time.zone.now + 2.hours, doctor_user: doctor.id, patient_user:patient.id)}
    scenario 'login as doctor' do
      visit new_doctor_session_path
      fill_in 'doctor_email', with: doctor.email
      fill_in 'doctor_password', with: doctor.password
      click_button 'Log in'
      expect(page).to have_content('Sign out')
    end
    scenario 'login as patient' do
      visit new_patient_session_path
      fill_in 'patient_email', with: patient.email
      fill_in 'patient_password', with: patient.password
      click_button 'Log in'
      expect(page).to have_content('Sign out')
    end
    scenario 'logout after login' do
      visit new_doctor_session_path
      fill_in 'doctor_email', with: doctor.email
      fill_in 'doctor_password', with: doctor.password
      click_button 'Log in'
      click_link 'Sign out'
      expect(page).to have_content('Sign in')
    end
    scenario 'validating email' do
      visit new_doctor_session_path
      fill_in 'doctor_email', with: 'thing@.com'
      fill_in 'doctor_password', with: doctor.password
      click_button 'Log in'
      expect(page).to have_content('Log In')
    end
    scenario 'validating password' do
      visit new_patient_session_path
      fill_in 'patient_email', with: patient.email
      fill_in 'patient_password', with: '56454'
      click_button 'Log in'
      expect(page).to have_content('Log In')
    end
  end
  context 'signup' do
    scenario 'fail signup' do
      visit new_doctor_registration_path
      click_button 'Sign Up'
      expect(page).to have_content('errors prohibited this doctor from being saved')
    end
    scenario 'name validation' do
      visit new_patient_registration_path
      fill_in 'patient_email', with: 'peter@example.com'
      fill_in 'patient_password', with: 'password'
      fill_in 'patient_password_confirmation', with: 'password'
      click_button 'Sign Up'
      expect(page).to have_content("Name can't be blank")
    end
    scenario 'DOB validation' do
      visit new_doctor_registration_path
      fill_in 'doctor_name', with: 'Peter'
      fill_in 'doctor_email', with: 'peter@example.com'
      fill_in 'doctor_password', with: 'password'
      fill_in 'doctor_password_confirmation', with: 'password'
      click_button 'Sign Up'
      expect(page).to have_content("Dob can't be blank")
    end
    scenario 'email validation' do
      visit new_patient_registration_path
      fill_in 'patient_name', with: 'Peter'
      fill_in 'patient_DOB', with: Date.new(2000, 9, 17)
      fill_in 'patient_password', with: 'password'
      fill_in 'patient_password_confirmation', with: 'password'
      click_button 'Sign Up'
      expect(page).to have_content("Email can't be blank")
    end
    scenario 'password validation' do
      visit new_doctor_registration_path
      fill_in 'doctor_name', with: 'Peter'
      fill_in 'doctor_DOB', with: Date.new(2000, 9, 17)
      fill_in 'doctor_email', with: 'peter@example.com'
      click_button 'Sign Up'
      expect(page).to have_content("Password can't be blank")
    end
    scenario 'Valid email' do
      visit new_patient_registration_path
      fill_in 'patient_name', with: 'Peter'
      fill_in 'patient_DOB', with: Date.new(2000, 9, 17)
      fill_in 'patient_email', with: 'peterexample.com'
      fill_in 'patient_password', with: 'password'
      fill_in 'patient_password_confirmation', with: 'password'
      click_button 'Sign Up'
      expect(page).to have_content('Email is invalid')
    end
  end  
end