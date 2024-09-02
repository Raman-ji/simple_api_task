class User < ApplicationRecord
  validates :username, uniqueness: { on: %i[create update] }
  validates :username, :password, :password_confirmation, presence: { on: :create }
  validates :password, confirmation: { message: 'password is not matching', on: :create }
  validates :password, length: { in: 7..12, message: 'Password should be greater than 7 or less than 12', on: :create }
end
