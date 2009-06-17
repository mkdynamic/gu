# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_gu_session',
  :secret      => 'c229ed83efcf97e156eef4661409d5805a95048369afcc429607dd7a0597d87c78b25f9809ff39ea7b22f46e90303e7381819c835c9bd2d257df29e5fe6933a3'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
