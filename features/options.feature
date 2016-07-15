Feature: Manage WordPress options

  Background:
    Given I am on "wp-login.php"
    And I fill in "log" with "pantheon"
    And I fill in "pwd" with "pantheon"
    And I press "wp-submit"
    Then print current URL
    And I should be on "/wp-admin/"

  Scenario: Update the site tagline
    When I go to "/"
    Then I should see "Just another WordPress site" in the ".site-description" element
    And I should not see "Pantheon upstream testing site" in the ".site-description" element

    When I go to "/wp-admin/options-general.php"
    And I fill in "blogdescription" with "Pantheon upstream testing site"
    And I press "submit"
    Then I should see "Settings saved."

    When I go to "/"
    Then I should see "Pantheon upstream testing site" in the ".site-description" element
    Then I should not see "Just another WordPress site" in the ".site-description" element

    When I go to "/wp-admin/options-general.php"
    And I fill in "blogdescription" with "Just another WordPress site"
    And I press "submit"
    Then I should see "Settings saved."

    When I go to "/"
    Then I should see "Just another WordPress site" in the ".site-description" element
    And I should not see "Pantheon upstream testing site" in the ".site-description" element
