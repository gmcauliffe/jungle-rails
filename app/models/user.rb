class User < ActiveRecord::Base
  
  has_secure_password
  has_many :reviews

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :password, presence: true, length: { minimum: 4 }
  validates :password_confirmation, presence: true

  def self.authenticate_with_credentials(email, password)
    strippedEmail = email.strip
    user = User.find_by_email(strippedEmail.downcase)
    user.authenticate(password)
  end

end
