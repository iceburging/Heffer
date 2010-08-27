Then /^a confirmation email should be dispatched to "([^\"]*)"$/ do |email|
  steps %Q{
    Then the email should be from "notification@#{DOMAIN}"
    And the email should be to "#{email}"
  }
  And 'the email subject should include "Order confirmation"'
end

Then /^the email should be from "([^\"]*)"$/ do |from|
  @email = ActionMailer::Base.deliveries.first
  assert_equal from, @email.from[0]
end

Then /^the email should be to "([^\"]*)"$/ do |to|
  @email = ActionMailer::Base.deliveries.first
  assert_equal to, @email.to[0]
end

Then /^the email subject should include "([^\"]*)"$/ do |text|
  @email = ActionMailer::Base.deliveries.first
  assert @email.subject.include?(text)
end

