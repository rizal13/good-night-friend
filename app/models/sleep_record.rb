class SleepRecord < ApplicationRecord
  belongs_to :user

  validates :clock_in, presence: true

  scope :last_week, -> { where(clock_in: 1.week.ago.beginning_of_day..Time.current) }
end
