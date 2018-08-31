class User < ActiveRecord::Base
  has_secure_password

  validates :email, presence: true, on: create
  validates :password, length: { minimum: 8 }, on: :create
  validates :password, confirmation: true, on: :create
  validates :password_confirmation, presence: true, on: :create

  validates :email, uniqueness: true



  has_many :projects
  has_many :pledges

  def has_pledged?(project)
    project.pledges.each do |project_pledge|
      self.pledges.each do |user_pledge|
        if user_pledge == project_pledge
          return true
        end
      end
    end

    return false
  end

  def projects_in_progress
    in_progress_projects = []
    projects.each do |project|
      if project.start_date < DateTime.now
        in_progress_projects << project.title
      end
    end
    return in_progress_projects
  end

  def projects_where_goal_met
    goal_met = {}
    projects.each do |project|
      ind_proj_fund = 0
      project.pledges.each do |pledge|
        ind_proj_fund += pledge.dollar_amount
      end
      if ind_proj_fund >= project.goal
        goal_met[project.title] = ind_proj_fund
      end
    end
    return goal_met
  end

  def fully_funded_total
    projects.each do |project|
      ind_proj_fund = 0
      project.pledges.each do |pledge|
        ind_proj_fund += pledge.dollar_amount
      end
      if ind_proj_fund >= project.goal
        goal_met << project.title
      end
    end
  end

  def projects_with_funds
    project_has_funds = 0
    projects_with_funding = []
    projects.each do |project|
      ind_proj_fund = 0
      project.pledges.each do |pledge|
        ind_proj_fund += pledge.dollar_amount
      end
      if ind_proj_fund > 0
        projects_with_funding << project.title
      end
    end
    return projects_with_funding
  end

  def total_money_pledged
    fund = 0
    projects.each do |project|
      project.pledges.each do |pledge|
        fund += pledge.dollar_amount
      end
    end
    return fund
  end

  def total_pledges
    funded_projects = 0
    projects.each do |project|
      project.pledges.each do |pledge|
        funded_projects += 1
      end
    end
    return funded_projects
  end

  def total_active_projects
    active_projects = []
    projects.each do |project|
      if project.start_date < DateTime.now
        active_projects << project.title
      end
    end
    return active_projects
  end
end
