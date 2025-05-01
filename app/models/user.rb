class User < ApplicationRecord
  has_secure_password
  has_many :scores
  validates :email, presence: true, uniqueness: true
end
