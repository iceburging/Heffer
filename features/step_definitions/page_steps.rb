Given /^I have created a page$/ do
  Given 'I have a menu entry titled "my menu"'
  When 'I go to the create page page'
  And 'I select "my menu" from "Menu Entry"'
  And 'I fill in "Title" with "test page"'
  And 'I fill in "Position" with "1"'
  And 'I fill in "Content" with "partial. test"'
  And 'I press "Create"'
end

When /^I visit the "([^\"]*)" semi\-static page in the "([^\"]*)" menu$/ do |page_title,menu_title|
  page = Page.find_by_title(page_title, :joins => :menu_entry, :conditions => {'menu_entries.title' => menu_title})
  visit static_path(page.menu_entry.permalink,page.permalink)
end

Then /^I should see the default message$/ do
  steps %Q{
    Then I should see "Exciting words from #{SIGNEE_POSITION.downcase}"
  }
end

