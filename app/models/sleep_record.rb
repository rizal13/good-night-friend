class SleepRecord < ApplicationRecord
  belongs_to :user

  scope :last_week, -> { where(clock_in: 1.week.ago.beginning_of_day..Time.current) }
  scope :last_week_by_users, ->(user_ids) { last_week.where(user: user_ids).order(created_at: :desc) }
end
