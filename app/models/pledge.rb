class Pledge < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :dollar_amount, presence: true
  validates :dollar_amount, numericality: { only_float: true }
  validates :user, presence: true
  validate :user_cannot_back_own_project
  validate :cannot_pledge_if_end_date_is_in_past
  validate :cannot_pledge_if_start_date_is_in_future  #comment this code out before rails db:seed

  def user_cannot_back_own_project
    if project.user == user
      errors.add(:user_id, "cannot back own project")
    end
  end

  def cannot_pledge_if_start_date_is_in_future
    if project.start_date > DateTime.now
      errors.add(:user_id, "cannot pledge a project before the start date.")
    end
  end

  def cannot_pledge_if_end_date_is_in_past
    if project.end_date < DateTime.now
      errors.add(:user_id, "cannot pledge a project after the end date.")
    end
  end
end
