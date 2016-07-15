Feature: Manage WordPress users

  Background:
    Given I am on "wp-login.php"
    And I fill in "log" with "pantheon"
    And I fill in "pwd" with "pantheon"
    And I press "wp-submit"
    Then print current URL
    And I should be on "/wp-admin/"

  Scenario: Create a new user
    When I go to "/wp-admin/user-new.php"
    And I fill in "user_login" with "pantheontestuser"
    And I fill in "email" with "test@example.com"
    And I fill in "pass1" with "password"
    And I fill in "pass2" with "password"
    And I press "createuser"
    Then print current URL
    And I should be on "/wp-admin/users.php?id=2"
    And I should see "New user created."
