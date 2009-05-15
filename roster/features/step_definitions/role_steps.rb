Given /^I have roles named (.+)$/ do |role_list|
	role_list.split(/\W/).map { |role| Role.create(:name => role) }
end

When /^I edit "([^\"]*)"$/ do |user_name|
	visit edit_user_path(User.find_by_name!(user_name))
end

Then /^I should see a list of all roles$/ do
	Role.all.each do |role|
  response.should contain(role.name)
	end
end

Given /^the following user records$/ do |table|
  # table is a Cucumber::Ast::Table
  table.hashes.each do |row|
    r = Role.create!(:name => row[:role])
    u = User.import_from_ldap(row[:netid], true)
    u.roles << r
    u.save
    u.id.should_not == nil
    c = Comment.create!(:title=>row[:comment], :user => u)
  end
end

Given /^I am logged in as "([^\"]*)"$/ do |arg1|
  @current_user = User.find_by_netid arg1
  puts @current_user.is_admin?
end

When /^I visit profile for "([^\"]*)"$/ do |arg1|
  @another_user = User.find_by_netid arg1
  visit edit_user_path(@another_user)
end

