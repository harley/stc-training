Given /^I have a user named (.+), netid (.+)$/ do |name, netid|
  User.create!(:name => name, :netid => netid)
end