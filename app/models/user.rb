class User < ActiveRecord::Base
  attr_accessor :password

  has_many :articles
  has_many :comments
  has_and_belongs_to_many :blogs

  validates :username, :password, :email, :presence => true, :on => :create
  validates_uniqueness_of :email
  validates_uniqueness_of :username

  before_save :encrypt_password

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def self.authenticate_token(token)
    user = find_by_auth_token(token)
    if user
      user
    else
      nil
    end
  end

end
