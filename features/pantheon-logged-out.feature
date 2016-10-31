Feature: Verify various Pantheon features as a logged-out user

  Scenario: Cache-Control should default to TTL=600
    When I go to "/"
    Then the response header "Cache-Control" should exist
    And the response header "Cache-Control" should contain "max-age=600"

  Scenario: Cache-Control should have "nocache" for logged-in users
    Given I log in as an admin

    When I go to "/"
    And the response header "Cache-Control" should contain "no-cache"
    And the response header "Cache-Control" should not contain "max-age=600"
