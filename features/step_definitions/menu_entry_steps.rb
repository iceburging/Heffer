Given /^I have a menu entry titled "([^\"]*)"$/ do |title|
  MenuEntry.create!(:title => title, :position => 1)
end

