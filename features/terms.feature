Feature: Manage WordPress terms

  Background:
    Given I am on "wp-login.php"
    And I fill in "log" with "pantheon"
    And I fill in "pwd" with "pantheon"
    And I press "wp-submit"
    Then print current URL
    And I should be on "/wp-admin/"

  Scenario: Create a new tag
    When I go to "/wp-admin/edit-tags.php?taxonomy=post_tag"
    And I fill in "tag-name" with "Pantheon Testing Tag"
    And I press "submit"
    Then print current URL
    And I should see "Tag added."
    And I should see "Pantheon Testing Tag"
