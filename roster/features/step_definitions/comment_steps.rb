Given /^I have a comment about (.+), with title (.+), with body (.+)$/ do |user_name, title, body|
  user = User.find_by_name(user_name)
  Comment.create!(:title => title, :body => body, :user_id => user.id)
end
