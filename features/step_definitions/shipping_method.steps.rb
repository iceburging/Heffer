Given /^The following shipping method records$/ do |table|
  table.hashes.each do |hash|
    hash.each do |key, value|
      case key
      when 'countries'
        hash[key] = value.split(', ').reduce([]) do |result, country|
          result << Country.find_by_name(country)
        end
      end
    end
     Factory.create(:shipping_method, hash)
  end
end

