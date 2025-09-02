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



🖼 UI Summary:
Profile Selector: Grid of profiles (Adult 👩, Baby 🍼).
Adult Dashboard: Habits list with checkboxes, streak counter, mini charts, optional Habit Garden.
Baby Dashboard: Quick log buttons, daily timeline, analytics charts.
Calendar View: Combined overview of adult habits + baby activities.



🔀 Mobile Support
MVP: Fully responsive Vue.js app (works on desktop and mobile browsers).
Upgrade Path: Convert to PWA for installability.
Future Expansion: Wrap in Capacitor to publish on iOS/Android app stores.



Adjust this once I get a little further in.
This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# Family-Habit-and-Activity-Tracker-Backend
