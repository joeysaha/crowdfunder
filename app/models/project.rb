require 'date'

class Project < ActiveRecord::Base
  has_many :rewards
  has_many :pledges
  has_many :users, through: :pledges # backers
  belongs_to :user # project owner

  validates :title, :description, :goal, :start_date, :end_date, :user_id, presence: true
  validates :goal, numericality: { only_float: true, greater_than: 0 }
  validate :start_date_cannot_be_in_the_past
  validate :end_date_cannot_be_before_start

# def date_cannot_be_in_the_past
#   if date.present? && date.past?
#     errors.add(:date, "can't be in the past")
#   end
# end

def start_date_cannot_be_in_the_past
  if self.start_date && self.start_date < DateTime.now
    errors.add(:date, "invalid. Start date can't be in the past")
  end
end

def end_date_cannot_be_before_start
  if self.end_date && self.start_date && self.end_date < self.start_date
    errors.add(:date, "invalid. End date can't be before the start date")
  end
end

# def end_date_cannot_be_before_start
#   if end_date >= start_date
#     errors
#   end
# end

end
