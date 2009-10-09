# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_beacon_sample_session',
  :secret      => '81c921f1c9c5417751ae159416c7eb97abca999cbb0ae451c1af8dc2d91c9d5ccb07f77b2a044b73fb6bbe5077043a38bcc912b5dc2822b6cedd6339189302b9'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
