Then /^check for presence of website address$/ do
  steps %Q{
    Then I should see "http://www.#{DOMAIN}"
  }
end

