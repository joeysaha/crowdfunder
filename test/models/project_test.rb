require 'test_helper'

class ProjectTest < ActiveSupport::TestCase

  def test_valid_project_start_date_is_in_past
    test_project = new_project
    test_project.start_date = Date.today - 1.day
    refute(test_project.valid?)
  end

  def test_valid_project_end_date_is_before_start_date
    test_project = new_project
    test_project.end_date = Date.today + 2.hour
    refute(test_project.valid?)
  end

  def test_valid_project_start_date_exists
    test_project = new_project
    test_project.start_date = nil
    refute(test_project.valid?)
  end

  def test_valid_project_end_date_exists
    test_project = new_project
    test_project.end_date = nil
    refute(test_project.valid?)
  end

  def test_valid_project_can_be_created
    owner = new_user
    owner.save
    project = new_project
    project.user = owner
    project.save
    assert project.valid?
    assert project.persisted?
    assert project.user
  end

  def test_project_is_invalid_without_owner
    project = new_project
    project.user = nil
    project.save
    assert project.invalid?, 'Project should not save without owner.'
  end

  def new_project
    Project.new(
      title:       'Cool new boardgame',
      description: 'Trade sheep',
      start_date:  Date.today + 1.day,
      end_date:    Date.today + 1.month,
      goal:        50000,
      user:        new_user
    )
  end

  def new_user
    User.destroy_all
    User.create(
      first_name:            'Sally',
      last_name:             'Lowenthal',
      email:                 'sally@example.com',
      password:              'passpass',
      password_confirmation: 'passpass'
    )
  end

end
