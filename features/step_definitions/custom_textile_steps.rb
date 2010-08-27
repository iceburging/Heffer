When /^I fill in "([^\"]*)" with textile body$/ do |field,textile|
  fill_in(field, :with => textile)
end

