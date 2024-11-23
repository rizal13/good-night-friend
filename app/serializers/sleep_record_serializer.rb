class SleepRecordSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :user_name, :clock_in, :clock_out, :duration

  def user_name
    object.user.name
  end

  def duration
    return nil unless object.clock_out && object.clock_in

    duration = (object.clock_out - object.clock_in).to_i
    hours =  duration / 3600
    remaining_minutes = duration % 3600 / 60

    "#{hours} hours, #{remaining_minutes} minutes"
  end
end
