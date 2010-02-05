# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_OurApp_session',
  :secret      => '7ba55caa8301ddb29491ee272b578f585f0a16702346a5548fbd88999147d3ebc96d9f1f00f8b338e3ed5a98c5fd4e524641f665ddcd9b198ca9a8bd34b4d1d0'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
