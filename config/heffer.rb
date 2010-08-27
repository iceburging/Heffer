# This file allows you to control some basic details of the website

DOMAIN = "example.co.uk"
# used to generate system email addresses e.g. petesusedcars.co.uk

SITE_NAME = "Example Business"
# the name of your website e.g. Pete's Used Cars

SIGNEE_NAME = "Some Fella"
# name displayed at bottom of emails etc. e.g. Pete

SIGNEE_POSITION = "Director"
# position of the signee e.g. Founder

SALES_NUMBER = "02079 250 918"
# telephone number sales can be placed via e.g. 02079 250 918

RETURNS_NUMBER = "02079 250 918"
# telephone number sales can be placed via e.g. 02079 250 918

PAYPAL_CREDENTIALS = {:login => "",
                      :password => "",
                      :login_pid_auth => "",
                      :login_mid_auth => "",
                      :password_auth => "" }
# paypal website payments pro (PayflowUK) credentials

ERROR_NOTIFICATION = {:recipients => ["some.fellas@example.co.uk"],
                      :prefix => "[Example Error]" }
# set who receives notification of errors e.g. ["usedcarpete@email.com","webguru@email.com"]
# and what the email is prefixed with e.g. "Oh no!"

CARDTYPES = {'Visa' => 'visa',
             'Mastercard' => 'master' }
# select supported card types full list given below:
# CARDTYPES = {'Visa' => 'visa',
#             'Mastercard' => 'master',
#             'American Express' => 'american_express',
#             'Discover' => 'discover',
#             'Solo' => 'solo',
#             'UK Maestro/Switch' => 'switch'}

