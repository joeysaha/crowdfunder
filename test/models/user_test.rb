require_relative '../test_helper'
require "minitest/autorun"



class UserTest < ActiveSupport::TestCase
  def test_email_must_be_unique
    user = User.create(email: "bettymaker@gmail.com", password: "12345678", password_confirmation: "12345678", first_name: "Josh", last_name: "Saha")
    user2 = User.new(email: "bettymaker@gmail.com", password: "00000000", password_confirmation: "00000000", first_name: "Josh", last_name: "Saha")
    refute user2.valid?
  end

  def test_user_must_include_password_confirmation_on_create
    user = User.new(email: "bettymaker@gmail.com", password: "12345678", first_name: "Josh", last_name: "Saha")
    refute user.valid?
  end

  def test_password_must_match_confirmation
    user = User.new(email: "bettymaker@gmail.com", password: "12345678", password_confirmation: "87654321", first_name: "Josh", last_name: "Saha")
    refute user.valid?
  end

  def test_password_must_be_at_least_8_characters_long
    user = User.new(email: "bettymaker@gmail.com", password: "1234", password_confirmation: "1234", first_name: "Josh", last_name: "Saha")
    refute user.valid?
  end

  def test_user_email_empty_invalid
    user = User.new(email: nil, password:"123456789", password_confirmation: "123456789", first_name: "Josh", last_name: "Saha")
    refute user.valid?
  end

  def test_user_password_less_than_8_char_invalid
    user = User.new(email: "tyler@yahoo.com", password:"123", password_confirmation: "123", first_name: "Josh", last_name: "Saha")
    refute user.valid?
  end

  def test_user_first_name_empty_invalid
    user = User.new(email: "tyler@yahoo.com", password:"123456789", password_confirmation: "123456789", first_name: nil, last_name: "Saha")
    refute user.valid?
  end

  def test_user_last_name_empty_invalid
    user = User.new(email: "tyler@yahoo.com", password:"123456789", password_confirmation: "123456789", first_name: nil, last_name: "Saha")
    refute user.valid?
  end

end
