# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Cleanup the existing data
User.destroy_all
Friend.destroy_all
SleepRecord.destroy_all


# Create users
users = []
3.times do |i|
  users << User.create!(name: "User #{i + 1}")
end

user_ids = users.map(&:id)

# Create sleep records for users
users.each_with_index do |user, i|
  5.times do
    user.sleep_records.create!(
      clock_in: Faker::Time.backward(days: 7, period: :evening),
      clock_out: Faker::Time.backward(days: 7, period: :morning)
    )
  end

  # Create friend followers
  user_ids.each do |uid|
    if user.id != uid
      candidate = users.find { |q| q.id == uid }
      relations = Friend.new(follower_user: user, following_user: candidate)
      user.following << relations
    end
  end
end

puts "Seed data created successfully!"
