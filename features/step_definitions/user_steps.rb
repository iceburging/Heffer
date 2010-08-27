Given /^A user called "([^\"]*)" exists$/ do |name|
  User.create({:name => name, :password => 'password'})
end

