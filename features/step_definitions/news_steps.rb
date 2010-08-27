Given /^The following news item[s]$/ do |table|
  table.hashes.each do |hash|
     Factory.create(:news_item, hash)
  end
end

