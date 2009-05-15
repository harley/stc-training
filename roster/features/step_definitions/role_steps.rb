Given /^I have roles named (.+)$/ do |role_list|
	role_list.split(/\W/).map { |role| Role.create(:name => role) }
end

When /^I edit "([^\"]*)"$/ do |arg1|
	visit edit_user_path(User.find_by_name!(user_name))
end

Then /^I should see a list of all roles$/ do
	Roles.all.each do |role|
  response.should contain(role.name)
	end
end

