Feature: Resave permalinks to fix mystery 404s

  Background:
    Given I log in as an admin

  Scenario: Resave permalinks
    When I go to "wp-admin/options-permalink.php"
    And I fill in "selection" with ""
    And I press "Save Changes"
    And I should see "Permalink structure updated."

    When I go to "wp-admin/options-permalink.php"
    And I fill in "selection" with "/%postname%/"
    And I press "Save Changes"
    And I should see "Permalink structure updated."

    #When I go to "wp-admin/options-general.php?page=pantheon-cache"


    When I go to "/wp-admin/options-general.php?page=pantheon-cache"
    Then I should see "Clear Site Cache"
    And I should not see "Site cache flushed."

    When I press "Clear Cache"
    Then print current URL
    And I should be on "/wp-admin/options-general.php?page=pantheon-cache&cache-cleared=true"
    And I should see "Site cache flushed." in the ".updated" element
