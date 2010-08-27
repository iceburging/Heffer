# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_Rosetta_session',
  :secret      => '736a3447c3722f2f4879475b3d5794de9d712c57f13fa09a31213a0b1d8f7971a2ad5bca88414cefe57bea9371adf40c3c9f02fb794a079808b092c1137bd5d7'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
ActionController::Base.session_store = :active_record_store

