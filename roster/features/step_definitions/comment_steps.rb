Given /^I have a comment titled (.+), with body (.+) and user (.+)$/ do |title, body, user_name|
  user = User.find_by_name(user_name)
  Comment.create!(:title => title, :body => body, :user_id => user.id)
end

Given /^I have no comments$/ do
  Comment.delete_all
end

Then /^I should have ([0-9]+) comment$/ do |count|
  Comment.count.should == count.to_i
end

