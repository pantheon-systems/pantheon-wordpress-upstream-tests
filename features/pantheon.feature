Feature: Perform Pantheon-specific actions

  Background:
    Given I am on "wp-login.php"
    And I fill in "log" with "pantheon"
    And I fill in "pwd" with "pantheon"
    And I press "wp-submit"
    Then print current URL
    And I should be on "/wp-admin/"

  Scenario: Change the cache TTL
    When I go to "/wp-admin/options-general.php?page=pantheon-cache"
    Then I should see "Pantheon Cache"
    And the "pantheon-cache[default_ttl]" field should contain "600"

    When I fill in "pantheon-cache[default_ttl]" with "300"
    And I press "submit"
    Then I should see "Settings saved."
    And the "pantheon-cache[default_ttl]" field should contain "300"

    When I fill in "pantheon-cache[default_ttl]" with "600"
    And I press "submit"
    Then I should see "Settings saved."
    And the "pantheon-cache[default_ttl]" field should contain "600"

  Scenario: Clear the site cache
    When I go to "/wp-admin/options-general.php?page=pantheon-cache"
    Then I should see "Clear Site Cache"
    And I should not see "Site cache flushed."

    When I press "Clear Cache"
    Then print current URL
    And I should be on "/wp-admin/options-general.php?page=pantheon-cache&cache-cleared=true"
    And I should see "Site cache flushed." in the ".updated" element
