# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_apods_session',
  :secret      => '7eeb1a9ca03b2c142120626c647f88d9e96ab0d4fdc73119b3ece0deefe265a0c2dd560002d0e0c61eba27bdf0fd814c19acaba7389c9a1c6c0dda55e61adc54'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
