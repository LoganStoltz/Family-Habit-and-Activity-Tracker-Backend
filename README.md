🗄 Database Schema:
Users
  id, firstName, lastName, userName, email, phoneNumber, password_hash
Profiles
  id, user_id, firstName, lastName, dob, type (adult/baby)
Habits (adults)
  id, profile_id, firstName, lastName, goal_type, goal_value
HabitLogs
  id, habit_id, date, completed, count, notes
BabyLogs
  id, profile_id, type (feeding/sleep/diaper/sickness/milestone), timestamp, details
Badges (later on)
  id, profile_id, name, earned_at



📡 Backend API (Sample):
POST /auth/register – register user
POST /auth/login – login
POST /profiles – add profile
GET /profiles – list profiles
POST /profiles/:id/habits – add habit
POST /habits/:id/logs – log habit completion
POST /profiles/:id/babylogs – log baby activity
GET /profiles/:id/analytics – analytics data


Adjust this once I get a little further in
