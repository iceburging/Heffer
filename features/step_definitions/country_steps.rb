Given /^The following country records$/ do |table|
  table.hashes.each do |hash|
    Factory.create(:country, hash)
  end
end

