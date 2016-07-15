Feature: Manage WordPress comments

  Scenario: Leave a comment logged-out
    When I go to "/hello-world/"
    Then print current URL
    And I should see "1 thought on “Hello world!”" in the "h2.comments-title" element
    And I should see "Leave a Reply"

    When I fill in "comment" with "Pantheon logged-out test comment"
    And I fill in "author" with "Pantheon Logged-Out"
    And I fill in "email" with "noreply@getpantheon.com"
    And I press "submit"
    Then print current URL
    And I should see "1 thought on “Hello world!”" in the "h2.comments-title" element
    And I should see "Your comment is awaiting moderation."
    And I should see "Pantheon logged-out test comment"

  Scenario: Leave a comment logged-in
    Given I am on "wp-login.php"
    And I fill in "log" with "pantheon"
    And I fill in "pwd" with "pantheon"
    And I press "wp-submit"
    Then print current URL
    And I should be on "/wp-admin/"

    When I go to "/hello-world/"
    Then print current URL
    And I should see "1 thought on “Hello world!”" in the "h2.comments-title" element
    And I should see "Leave a Reply"

    When I fill in "comment" with "Pantheon logged-in test comment"
    And I press "submit"
    Then print current URL
    And I should see "2 thoughts on “Hello world!”" in the "h2.comments-title" element
    And I should see "Pantheon logged-in test comment"

  Scenario: View comments in the backend
  	Given I am on "wp-login.php"
    And I fill in "log" with "pantheon"
    And I fill in "pwd" with "pantheon"
    And I press "wp-submit"
    Then print current URL
    And I should be on "/wp-admin/"

    When I go to "/wp-admin/edit-comments.php"
    Then print current URL
    And I should be on "/wp-admin/edit-comments.php"
    And I should see "Pantheon logged-out test comment"
    And I should see "Pantheon logged-in test comment"
