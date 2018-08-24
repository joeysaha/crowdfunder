class Pledge < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :dollar_amount, presence: true
  validates :user, presence: true
  validate :user_cannot_back_own_project

  def user_cannot_back_own_project
    if project.user == user
      errors.add(:user_id, "cannot back own project")
    end
  end
end
