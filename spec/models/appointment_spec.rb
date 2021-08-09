require 'rails_helper'
require 'capybara/rspec'

RSpec.describe Appointment, type: :model do
  context 'Appointments associations tests' do
    it { should belong_to(:doctor) }
    it { should belong_to(:patient)  }
  end
  context 'Validations for appointments' do
    it { should validate_presence_of(:subject) }
    it { should validate_presence_of(:starts_at) }
    it { should validate_presence_of(:ends_at) }
    it { should validate_length_of(:subject).is_at_most(50).with_long_message('50 characters in subject is the maximum allowed.') }
  end
end