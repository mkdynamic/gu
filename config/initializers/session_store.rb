# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_gu_session',
  :secret      => '8a90f97e3aa60f2fef396b3fd51236ed4a9db05a95a6c2616508140a05cc309f044eae289a5be9211655ea9715ad51b81ab3f933216f48a390f0fb703eda089a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
