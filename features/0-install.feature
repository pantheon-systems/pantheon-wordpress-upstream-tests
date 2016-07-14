Feature: Install WordPress through the web UI

  Scenario: Install WordPress with the en_US locale
    When I go to "/"
    Then print current URL
    And I should be on "/wp-admin/install.php"
    And I should see "Welcome to the famous five-minute WordPress installation process!"

    When I fill in "weblog_title" with "Pantheon WordPress Upstream"
    And I fill in "user_name" with "pantheon"
    And I fill in "admin_password" with "pantheon"
    And I fill in "admin_password2" with "pantheon"
    And I check "pw_weak"
    And I fill in "admin_email" with "wordpress-upstream@getpantheon.com"
    And I press "submit"
    Then print current URL
    And I should be on "/wp-admin/install.php?step=2"
    And I should see "WordPress has been installed."

  Scenario: Attempting to install WordPress a second time should error
    When I go to "/wp-admin/install.php"
    Then I should see "You appear to have already installed WordPress."
