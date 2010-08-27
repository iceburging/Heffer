Given /^I have product lines named (.+)$/ do |names|
  names.split(', ').each do |name|
    ProductLine.create!(:name => name)
  end
end

Given /^I have manufacturers named (.+)$/ do |names|
  names.split(', ').each do |name|
    Factory.create(:manufacturer, :name => name)
  end
end


Given /^I have categories titled (.+)$/ do |titles|
  titles.split(', ').each do |title|
    Category.create!(:title => title)
  end
end

Given /^I have flags titled (.+)$/ do |titles|
  titles.split(', ').each do |title|
    Flag.create!(:title => title)
  end
end

Given /^The following product line record[s]$/ do |table|
  table.hashes.each do |hash|
    hash.each do |key, value|
      case key
      when 'category'
        hash[key] = Category.find_by_title(hash['category'])
      when 'manufacturer'
        hash[key] = Manufacturer.find_by_name(hash['manufacturer'])
      when 'flags'
        flags = []
        value.split(', ').each do |flag|
          flags << Flag.find_by_title(flag)
        end
        hash[key] = flags
      end
    end
     Factory.create(:product_line, hash)
  end
end

Given /^An example product exists$/ do
  Factory.create(:example_product)
end

Given /^A sensible example product exists$/ do
  Factory.create(:sensible_example_product)
end

