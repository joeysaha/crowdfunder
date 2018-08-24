class User < ActiveRecord::Base
  has_secure_password

  validates :email, presence: true, on: create
  validates :password, length: { minimum: 8 }, on: :create
  validates :password, confirmation: true, on: :create
  validates :password_confirmation, presence: true, on: :create

  validates :email, uniqueness: true

  has_many :projects
  has_many :pledges
end
