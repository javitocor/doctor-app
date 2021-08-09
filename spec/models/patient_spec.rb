require 'rails_helper'
require 'capybara/rspec'

RSpec.describe Patient, type: :model do
  context 'User associations tests' do
    it { should have_many(:appointments) }
    
  end
  context 'Validations for users' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:surname) }
    it { should validate_presence_of(:medical_history) }
    it { should validate_presence_of(:DOB) }
    it { should validate_presence_of(:email) }
    it { should validate_length_of(:name).is_at_most(45).with_long_message('45 characters in patient name is the maximum allowed.')  }
    it { should validate_length_of(:surname).is_at_most(45).with_long_message('45 characters in patient surname is the maximum allowed.')  }
  end  
end