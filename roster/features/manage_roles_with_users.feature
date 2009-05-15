@roles
Feature: Manage Users By Role
  In order to manage user details
  As a security enthusiast
  I want to edit my comment only when authorized

  Scenario Outline: Show or hide edit comment link
    Given the following user records
      | netid | role     | comment  |
      | dtt22 | admin    | funny    |
      | alb64 | guest    | not funny|
    Given I am logged in as "<current_user>"
    When I visit profile for "<another_user>"
    Then I should <action>

    Examples:
      | current_user | another_user | action                 |
      | dtt22        | alb64        | not see "Add comment"  |
      | alb64        | dtt22        | see "Add comment"      |
      | dtt22        | dtt22        | see "Add comment"      |

