require 'rails_helper'
require 'capybara/rspec'

RSpec.describe SearchesController, type: :feature do
  context 'Testing search bar' do
    let(:doctor) { Doctor.create({ name: 'Sally', email: 'sally@example.com', password: 'aaaaaaaa', password_confirmation: 'aaaaaaaa', DOB: Date.new(1980, 9, 17), graduated: 2001, city: 'Barcelona', resume:'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris posuere ante eget lacus ultricies, et laoreet nunc scelerisque. Curabitur vulputate suscipit pellentesque. Nunc molestie purus nisl, eu porttitor lorem pretium a. Duis sagittis, dui id lobortis gravida, quam diam placerat magna, lobortis tempor odio erat vitae felis. Nulla venenatis est lorem. Suspendisse dapibus ante odio, vel consectetur diam rhoncus varius. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nullam vitae porta metus. Mauris porta at massa quis iaculis. Aenean et blandit tellus. Donec pellentesque ipsum metus.' })}
    let(:patient) { Patient.create({ name: 'John', surname: 'Wilkins', email: 'john@example.com', password: 'aaaaaaaa', password_confirmation: 'aaaaaaaa', DOB: Date.new(1965, 9, 11), city: 'Montpellier', medical_history:'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris posuere ante eget lacus ultricies, et laoreet nunc scelerisque. Curabitur vulputate suscipit pellentesque. Nunc molestie purus nisl, eu porttitor lorem pretium a. Duis sagittis, dui id lobortis gravida, quam diam placerat magna, lobortis tempor odio erat vitae felis. Nulla venenatis est lorem. Suspendisse dapibus ante odio, vel consectetur diam rhoncus varius. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nullam vitae porta metus. Mauris porta at massa quis iaculis. Aenean et blandit tellus. Donec pellentesque ipsum metus.' }) }
    before :each do
      visit new_patient_session_path
      fill_in 'patient_email', with: patient.email
      fill_in 'patient_password', with: patient.password
      click_button 'Log in'
      sleep(2)
      visit doctors_path
    end
    scenario 'Testing search bar' do
      fill_in 'search', with: 'Sally'
      click_button 'Search'
      sleep(2)
      expect(page).to have_content('Search Result')
    end
  end
end