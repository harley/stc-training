@roles
Feature: Manage Roles
	In order to make a roster
	As an administrator
	I want to create and manage roles

	Scenario: Assigning role to a user
		Given I have a user named Adam Bray, netid alb64
		And I have roles named "admin", "guest"
		When I edit "Adam Bray"
		Then I should see a list of all roles
		
