class User < ApplicationRecord
  include SecureRandom
  after_initialize :assign_api_key, :downcase_email

  has_secure_password
  validates :email, presence: true
  validates :email, uniqueness: true
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  validates :password, presence: true, length: { minimum: 6 }
  validates :password, confirmation: { case_sensitive: true }

  def assign_api_key
    self.api_key = SecureRandom.base64.tr('+/=', 'Qrt')
  end

  def downcase_email
    self.email = self.email.downcase if self.email 
  end
end
