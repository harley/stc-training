Feature: Manage Comments
	In order to make a list of comments
	As an administrator
	I want to create and manage comments

	Scenario: Comment List
		Given I have a user named Adam Bray, netid alb64
		Given I have a comment about Adam Bray, with title Good Boy, with body He writes tests for all features!
		When I go to the list of comments
		Then I should see "Adam Bray"
		And I should see "Good Boy"
		And I should see "He writes tests for all features!"
		

	Scenario: Create valid comment
		Given I have no comments
		Given I have a user named Harley Trung, netid dtt22
		And I am on the list of comments
		When I follow "New comment"
		And I fill in "Title" with "Pretentious"
		And I fill in "Body" with "He never writes tests"
		And I select "Harley Trung" from "User"
		And I press "Create"
		Then I should see "New Comment Created."
		And I should see "Harley Trung"
		And I should see "Pretentious"
		And I should have 1 comment

	Scenario: Edit Comment
		Given I have no comments
		Given I have a user named Adam Bray, netid alb64
		And I have a user named Harley Trung, netid dtt22
		Given I have a comment about Adam Bray, with title Good Boy, with body He writes tests for all features!
		When I go to the list of comments
		And I follow "Edit"
		And I fill in "Title" with "Pretentious"
		And I fill in "Body" with "He never writes tests"
		And I select "Harley Trung" from "User"
		And I press "Create"
		Then I should see "Successfully updated comment."
		And I should see "Harley Trung"
		And I should see "Pretentious"
		And I should have 1 comment

