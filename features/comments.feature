Feature: Manage WordPress comments

  Scenario: Leave a comment logged-in
    Given I log in as an admin

    When I go to "/hello-world/"
    Then print current URL
    And I should see "One Reply to “Hello world!”" in the "h2.comments-title" element
    And I should see "Leave a Reply"

    When I fill in "comment" with "Pantheon logged-in test comment"
    And I press "submit"
    Then print current URL
    And I should see "2 Replies to “Hello world!”" in the "h2.comments-title" element
    And I should see "Pantheon logged-in test comment"

  Scenario: View comments in the backend
    Given I log in as an admin

    When I go to "/wp-admin/edit-comments.php"
    Then print current URL
    And I should be on "/wp-admin/edit-comments.php"
    And I should see "Pantheon logged-in test comment"
