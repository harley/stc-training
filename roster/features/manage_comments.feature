Feature: Manage Comments
	In order to make comments on users
	As an administrator
	I want to create and manage comments
	
	Scenario: Comment List
	  Given I have a user named Adam Bray, netid alb64	
		Given I have a comment titled Good Boy, with body Adam wrote lots of tests and user Adam Bray
		When I go to the list of comments
		Then I should see "Good Boy"
		
	Scenario: Create Valid Comment
		Given I have no comments
		Given I have a user named Adam Bray, netid alb64	
		And I am on the list of comments
		When I follow "New Comment"
		And I fill in "Title" with "Mixed Review"
		And I select "Adam Bray" from "User"
		And I press "Create"
		Then I should see "New comment created."
#		And I should see "alb64"
#		And I should see "Adam Bray"
		And I should have 1 comment