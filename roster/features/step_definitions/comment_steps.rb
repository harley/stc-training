require 'casclient'
require 'casclient/frameworks/rails/filter'

Given /^I have a comment about (.+), with title (.+), and with body (.+)$/ do |user_name, title, body|
  Comment.create!(:user_id => User.find_by_name(user_name).id, :title => title, :body => body)
end

Given /^I am logged into CAS$/ do
  visit users_path
  fill_in "Netid", :with => 'catest'
  fill_in "Password", :with => 'need2ask'
  click_button "Login"
end