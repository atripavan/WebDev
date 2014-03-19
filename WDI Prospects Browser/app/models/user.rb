class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation

  attr_accessor :password
  #Encrypt password, and generate password salt and hash before saving user record
  before_save :encrypt_password

  validates :name,  :presence => true
  validates :email, :presence => true, :uniqueness => true
  validates :password, :presence => true,
  :length => { :minimum => 5, :maximum => 40 },
  :confirmation => true
  validates :password_confirmation, :presence => true

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
  def encrypt_password
      if password.present?
        self.password_salt = BCrypt::Engine.generate_salt
        self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
      end
  end
  
end
