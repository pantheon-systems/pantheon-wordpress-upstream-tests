Feature: Manage WordPress posts

  Background:
    Given I log in as an admin

  Scenario: Create and publish a blog post
    When I go to "/wp-admin/plugin-install.php?tab=plugin-information&plugin=classic-editor"
    And I press "#plugin_install_from_iframe"
    Then print the current URL
    And I should see "Successfully installed the plugin Classic Editor"

    When I go to "/wp-admin/plugins.php"
    And I press "#activate-classic-editor"
    Then I should see "Plugin activated."
    
    When I go to "/wp-admin/post-new.php"
    And I fill in "post_title" with "Awesome Post"
    And I fill in "post_name" with "awesome-post"
    And I press "publish"
    Then print current URL
    And I should see "Post published."

    When I go to "/awesome-post/"
    Then print current URL
    And I should see "Awesome Post"
