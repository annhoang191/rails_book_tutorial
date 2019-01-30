class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true, length: {maximum: Settings.user.name.maximum}
  validates :email, presence: true, length: {maximum: Settings.user.email.maximum},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}

  before_save :downcase_email
  has_secure_password
  validates :password, presence: true, length: {minimum: Settings.user.password.minimum}

  private

  def downcase_email
    self.email.downcase!
  end
end
