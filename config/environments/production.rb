# Settings specified here will take precedence over those in config/environment.rb

# The production environment is meant for finished, "live" apps.
# Code is not reloaded between requests
config.cache_classes = true

# Full error reports are disabled and caching is turned on
config.action_controller.consider_all_requests_local = false
config.action_controller.perform_caching             = true
config.action_view.cache_template_loading            = true

# See everything in the log (default is :info)
# config.log_level = :debug

# Use a different logger for distributed setups
# config.logger = SyslogLogger.new

# Use a different cache store in production
# config.cache_store = :mem_cache_store

# Enable serving of images, stylesheets, and javascripts from an asset server
# config.action_controller.asset_host = "http://assets.example.com"

# Disable delivery errors, bad email addresses will be ignored
config.action_mailer.raise_delivery_errors = false

# set email delivery method
config.action_mailer.delivery_method = :sendmail

ActionMailer::Base.sendmail_settings = {
 :location       => '/usr/sbin/sendmail',
 :arguments      => '-i -t'
}

# Enable threaded mode
# config.threadsafe!

# set the payment gateway
config.after_initialize do
  ActiveMerchant::Billing::Base.mode = :production
  ::GATEWAY = ActiveMerchant::Billing::PayflowUkGateway.new(
    :login => PAYPAL_CREDENTIALS[:login],
    :password => PAYPAL_CREDENTIALS[:password],
    :login_pid_auth => PAYPAL_CREDENTIALS[:login_pid_auth],
    :login_mid_auth => PAYPAL_CREDENTIALS[:login_mid_auth],
    :password_auth => PAYPAL_CREDENTIALS[:password_auth]
  )
end

