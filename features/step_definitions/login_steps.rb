Given /^I am logged in as admin$/ do
  Given 'A user called "admin" exists'
  And 'I am on the login page'
  When 'I fill in "name" with "admin"'
  And 'I fill in "password" with "password"'
  And 'I press "Login"'
  Then 'I should be on the private index page'
end

