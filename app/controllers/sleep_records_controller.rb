class SleepRecordsController < ApplicationController
  before_action :validates_clock_out, only: [ :clock_out ]

  def my_sleep_records
    render_api(:ok, "ok", my_weekly_sleeps)
  end

  def following_sleep_records
    render_api(:ok, "ok", following_weekly_sleeps)
  end

  def follower_sleep_records
    render_api(:ok, "ok", follower_weekly_sleeps)
  end

  def clock_in
    return render_api(:unprocessable_entity, new_sleep_record.errors.full_messages.first) unless new_sleep_record.save

    render_api(:created, "ok", clock_in_times)
  end

  def clock_out
    return render_api(:unprocessable_entity, exist_sleep_record.errors.full_messages.first) unless exist_sleep_record.update(clock_out: Time.current)

    render_api(:ok, "ok", exist_sleep_record)
  end

  private

  def exist_user
    @user ||= User.find(params[:user_id])
  end

  def clock_in_times
    @clock_ins ||= SleepRecord.select(:id, :clock_in, :created_at).order(created_at: :desc)
  end

  def my_weekly_sleeps
    @my_sleeps ||= SleepRecord.includes(:user)
                              .last_week_by_users(exist_user)

    sleep_record_serializers(@my_sleeps)
  end

  def following_weekly_sleeps
    @following_sleeps ||= SleepRecord.includes(:user)
                                     .last_week_by_users(exist_user.following.map(&:friend_id))

    sleep_record_serializers(@following_sleeps)
  end

  def follower_weekly_sleeps
    @follower_sleeps ||= SleepRecord.includes(:user)
                                    .last_week_by_users(exist_user.followers.map(&:user_id))

    sleep_record_serializers(@follower_sleeps)
  end

  def sleep_record_serializers(data)
    ActiveModelSerializers::SerializableResource.new(data,
                                                    each_serializer: SleepRecordSerializer,
                                                    adapter: :attributes).as_json
  end

  def new_sleep_record
    @new_sleep_record ||= SleepRecord.new(user_id: params[:user_id], clock_in: Time.current)
  end

  def exist_sleep_record
    @exist_sleep_record ||= SleepRecord.find_by(id: params[:id])
  end

  def validates_clock_out
    return render_api(:not_found, "Sleep record not found") unless exist_sleep_record.presence

    render_api(:unprocessable_entity, "Clock-out already set") if exist_sleep_record.clock_out.presence
  end
end
