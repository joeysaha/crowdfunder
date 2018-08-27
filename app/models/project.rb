class Project < ActiveRecord::Base
  has_many :rewards
  has_many :pledges
  has_many :users, through: :pledges # backers
  belongs_to :user # project owner

  validates :title, :description, :goal, :start_date, :end_date, :user_id, presence: true
  validate :date_cannot_be_in_the_past
  validate :end_date_cannot_be_before_start

def date_cannot_be_in_the_past
  if date.present? && date.past?
    errors.add(:date, "can't be in the past")
  end
end

# def end_date_cannot_be_before_start
#   if end_date >= start_date
#     errors
#   end
# end

end
