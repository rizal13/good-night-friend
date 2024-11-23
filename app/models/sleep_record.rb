class SleepRecord < ApplicationRecord
  belongs_to :user

  scope :last_week, -> { where(clock_in: 1.week.ago.beginning_of_day..Time.current).order(cico_duration_sql) }
  scope :last_week_by_users, ->(user_ids) { last_week.where(user: user_ids) }

  private

  def self.cico_duration_sql
    Arel.sql("CAST((strftime('%s', clock_out) - strftime('%s', clock_in)) AS INTEGER) DESC")
  end
end
