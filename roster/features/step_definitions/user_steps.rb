Given /^I have a user named (.+), netid (.+)$/ do |name, netid|
  User.create!(:name => name, :netid => netid)
end

# Given /^I have no users$/ do
#   User.delete_all
# end
# 
# Then /^I should have ([0-9]+) user$/ do |count|
#   User.count.should == count.to_i
# end