require 'rails_helper'

RSpec.describe User, type: :model do
  subject = User.create({ first_name: 'Bill', 
    last_name: 'Bloggs', 
    email: 'bill@bloggs.com', 
    password: 'billy', 
    password_confirmation: 'billy' })

  describe 'Validations' do
    
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end
  
    it "is not valid without a first name" do
      subject.first_name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a last name" do
      subject.last_name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without an email" do
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a password" do
      subject.password = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a password confirmation" do
      subject.password_confirmation = nil
      expect(subject).to_not be_valid
    end

    it "is not valid with a password shorter than 4" do
      subject.password = 'bil'
      expect(subject).to_not be_valid
    end

    it "is not valid if the password and password_confirmation do not match" do
      subject.password_confirmation = 'billo'
      expect(subject).to_not be_valid
    end

    it "is not valid if the email already exists in the database" do
      subject.email = 'PETER@piper.com'
      expect(subject).to_not be_valid
    end
    
  end

  describe '.authenticate_with_credentials' do
    
    it "is successful if the password matches the database" do
      person = User.authenticate_with_credentials('bill@bloggs.com', 'billy')
      expect(person).to be_instance_of(User)
    end

    it "is not successful if the password does not match the database" do
      user = User.authenticate_with_credentials('bill@bloggs.com', 'franklin')
      expect(user).to be false
    end

    it "is successful if email has leading or trailing spaces" do
      person = User.authenticate_with_credentials(' bill@bloggs.com ', 'billy')
      expect(person).to be_instance_of(User)
    end

    it "is successful if email has wrong case" do
      person = User.authenticate_with_credentials('biLL@bloggs.com', 'billy')
      expect(person).to be_instance_of(User)
    end

    
  end
end
