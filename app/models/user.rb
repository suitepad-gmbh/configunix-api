class User < ActiveRecord::Base

  # validations
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true

  # encrypt password
  def password=(value)
    super(value.present? ? UnixCrypt::SHA512.build(value, nil, 10000) : nil)
  end

  # validate password
  def validate_password(value)
    UnixCrypt.valid?(value, password)
  end

  def self.authenticate!(email, password)
    user = User.where(email: email).first
    return nil unless user.present?
    return nil unless user.validate_password password
    user
  end

end
