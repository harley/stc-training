Given /^I have a comment about (.+), with title (.+), and with body (.+)$/ do |user_name, title, body|
  Comment.create!(:user_id => User.find_by_name(user_name).id, :title => title, :body => body)
end
