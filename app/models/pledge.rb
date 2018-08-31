class Pledge < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :dollar_amount, presence: true
  validates :dollar_amount, numericality: { only_float: true, greater_than: 0 }
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







  def pledge_show(project_pledges)
    pledges_hash = {}
    project_pledges.each do |proj_pledges|
      pledges_hash[proj_pledges.user.first_name] = proj_pledges.dollar_amount
    end
    return pledges_hash
  end

  def pledges_total(project_pledges)
    total_pledge_money = 0
    project_pledges.each do |proj_pledges|
      total_pledge_money += proj_pledges.dollar_amount
    end
    return total_pledge_money
  end

  def pledge_same_user(project_pledges, currentuser)
    project_pledges.each do |proj|
      if proj.user == currentuser
        return true
      end
    end
    return false
  end
end
