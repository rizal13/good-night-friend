class SleepRecordsController < ApplicationController
  before_action :validates_clock_out, only: [ :clock_out ]

  def index
    sleep_records = SleepRecord.order(created_at: :desc)
    render_api(:ok, "ok", sleep_records)
  end

  def my_sleep_records
    render_api(:ok, "ok", my_sleep_result)
  end

  def following_sleep_records
    render_api(:ok, "ok", following_sleep_result)
  end

  def follower_sleep_records
    render_api(:ok, "ok", follower_sleep_result)
  end

  def clock_in
    return render_api(:unprocessable_entity, new_sleep_record.errors.full_messages.first) unless new_sleep_record.save

    render_api(:created, "ok", new_sleep_record)
  end

  def clock_out
    return render_api(:unprocessable_entity, exist_sleep_record.errors.full_messages.first) unless exist_sleep_record.update_attributes(clock_out: Time.current)

    render_api(:ok, "ok", exist_sleep_record)
  end

  private

  def current_user
    @user ||= User.find(params[:user_id])
  end

  def following_sleep_rec_result
    @sleep_records ||= SleepRecord
                       .last_week
                       .where(user: current_user.following.map(&:friend_id))
  end

  def my_sleep_result
    @my_sleeps ||= SleepRecord
                   .includes(:user)
                   .last_week
                   .where(user_id: params[:user_id])
                   .order(created_at: :desc)

    ActiveModelSerializers::SerializableResource.new(@my_sleeps,
                                                    each_serializer: SleepRecordSerializer,
                                                    adapter: :attributes).as_json
  end

  def following_sleep_result
    @following_sleeps ||= SleepRecord.includes(:user).last_week_by_users(current_user.following.map(&:friend_id))

    ActiveModelSerializers::SerializableResource.new(@following_sleeps,
                                                    each_serializer: SleepRecordSerializer,
                                                    adapter: :attributes).as_json
  end

  def follower_sleep_result
    @follower_sleeps ||= SleepRecord.includes(:user).last_week_by_users(current_user.followers.map(&:user_id))

    ActiveModelSerializers::SerializableResource.new(@follower_sleeps,
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
