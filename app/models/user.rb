# frozen_string_literal: true

class User < ApplicationRecord
  has_many :comments
  before_save { self.email = email.downcase }
  validates :username, presence: true, length:{maximum: 20}
  validates :email, presence: true, uniqueness: { case_sensitivie: false }
  validates :password_digest, presence: true
  has_secure_password
end
