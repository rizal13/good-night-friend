class SleepRecordSerializer < ActiveModel::Serializer
  attributes :id, :user_name, :clock_in, :clock_out, :duration

  def user_name
    object.user.name
  end

  def duration
    return nil unless object.clock_out && object.clock_in

    (object.clock_out - object.clock_in).to_i
  end
end
