Given /^I have no (.+)$/ do |class_name|
  class_name.singularize.capitalize.constantize.delete_all
end

Then /^I should have ([0-9]+) (.+)$/ do |count, class_name|
  class_name.singularize.capitalize.constantize.count.should == count.to_i
end