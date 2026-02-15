# frozen_string_literal: true

# Configure cookie-based session store for cross-site usage.
Rails.application.config.session_store :cookie_store,
  key: '_family_habit_session',
  same_site: :none,
  secure: true
