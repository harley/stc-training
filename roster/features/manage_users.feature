Feature: Manage Users
	In order to make a roster
	As an administrator
	I want to create and manage users
	
	Scenario: User List
		Given I have a user named Adam Bray, netid alb64
		And I have a user named Harley Trung, netid dtt22
		When I go to the list of users
		Then I should see "Adam Bray"
		And I should see "Harley Trung"
		
	Scenario: Create Valid User
		Given I have no users
		And I am on the list of users
		When I follow "New User"
		And I fill in "Netid" with "alb64"
		And I fill in "Name" with "Adam Bray"
		And I press "Create"
		Then I should see "New user created."
		And I should see "alb64"
		And I should see "Adam Bray"
		And I should have 1 user