# Good Night Friend API
Good Night Friend is a RESTful API built with Ruby on Rails that allows users to track their sleep records and follow/unfollow other users. It enables users to view their sleep records and the sleep records of their friends from the past week, sorted by sleep duration.


# Features
* **Clock In**: Users can clock in to record their sleep start time.
* **Clock Out**: Users can clock out to record their sleep end time.
* **Follow/Unfollow Friends'**: Users can follow and unfollow other users.
* **View Friends' Sleep Records**: Users can view the sleep records of their friends for the past week, sorted by sleep duration.


# API Endpoints
## Sleep Records
1. Clock In \
**POST** ```/sleep_records/clock_in``` \
Body Params: ***user_id** (current user id) \
Records the start of a user's sleep.

2. Clock Out \
**PATCH** ```/sleep_records/clock_out/{id}``` \
Path Params: ***id** (sleep record id) \
Records the end of a user's sleep.

3. Get My Sleep Records \
**GET** ```/sleep_records/{user_id}/me``` \
Path Params: ***{user_id}** (current user id) \
Returns all sleep records for current users from previous week.

4. Get Following Friend Sleep Records \
**GET** ```/sleep_records/{user_id}/following``` \
Path Params: ***{user_id}** (current user id) \
Returns all sleep records for following users from previous week.

5. Get Follower Friend Sleep Records \
**GET** ```/sleep_records/{user_id}/follower``` \
Path Params: ***{user_id}** (current user id) \
Returns all sleep records for user followers from previous week.

## Friends Relationship
1. Follow a Friend \
**POST** ```/friends``` \
Body Params: ***user_id** (follower user id), ***friend_id** (following user id) \
Creates a friend follow relationship between two users.

2. Unfollow a Friend \
**DELETE** ```/friends/{user_id}``` \
Path Params: ***{user_id}** (follower user id) \
Body Params: ***friend_id** (following user id) \
Remove a friend follow relationship between two users.


# Getting Started
## Prerequisites
* Ruby 3.3.6
* Rails 8.0.0
* SQLite
* Bundler
* Docker / Compose  

## Installation
### Local Installation
1. Clone the repository:
```
git clone https://github.com/rizal13/good-night-friend.git
cd good-night-friend
```

2. Install dependencies:
```
bundle install
```

3. Set up the database:
```
rails db_prepare
```

4. Start Rails Server:
```
rails s
```

5. The API is now available at http://localhost:3000.

### Docker Installation
1. Clone the repository:
```
git clone https://github.com/rizal13/good-night-friend.git
cd good-night-friend
```

2. Install dependencies:
```
bundle install
```

3. Start the containers:
```
docker compose up
```

4. The API is now available at http://localhost:3000.


# Testing
This project utilizes Minitest for its simplicity and suitability for demonstration purposes in the assessment.
* Additionally, it integrates the ```codecov``` gem to measure and report code coverage.

Run the test suite with:
```
rails test
```
<img width="1499" alt="image" src="https://github.com/user-attachments/assets/882f2725-0af1-4f44-8277-c9b735c690df">


# Example Usage
## Clock In
```
curl -X POST http://localhost:3000/sleep_records/clock_in \
-H "Content-Type: application/json" \
-d '{"user_id": 1}'
```

## Clock Out
```
curl -X PATCH http://localhost:3000/sleep_records/clock_out/3 \
-H "Content-Type: application/json"
```

## Following Friend Sleep Records
```
curl -X GET http://localhost:3000/sleep_records/2/following \
-H "Content-Type: application/json"
```

## Follow a User
```
curl -X POST http://localhost:3000/friends \
-H "Content-Type: application/json" \
-d '{"user_id": 1, "friend_id": 2}'
```

## Unfollow a User
```
curl -X DELETE http://localhost:3000/friends/1 \
-H "Content-Type: application/json" \
-d '{"friend_id": 2}'
```
