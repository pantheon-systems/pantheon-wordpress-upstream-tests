<?php


namespace PantheonSystems\PantheonWordPressUpstreamTests\Behat;

use Behat\Behat\Context\Context;
use Behat\Behat\Context\SnippetAcceptingContext;
#use Behat\MinkExtension\Context\MinkContext;
use Behat\Behat\Hook\Scope\BeforeScenarioScope;

/**
 * Define application features from the specific context.
 */
class AdminLogIn implements Context, SnippetAcceptingContext {

    /** @var \Behat\MinkExtension\Context\MinkContext */
    private $minkContext;

    /** @BeforeScenario */
    public function gatherContexts(BeforeScenarioScope $scope)
    {
        $environment = $scope->getEnvironment();
        $contexts = $environment->getContexts();
        foreach($contexts as $context) {
          if (is_a($context, 'Behat\MinkExtension\Context\MinkContext')) {
              $this->minkContext = $context;
          }
        }
    }

    /**
     * @Given I log in as an admin
     */
    public function ILogInAsAnAdmin()
    {
        $this->minkContext->visit('wp-login.php');
        $this->minkContext->fillField('log', getenv('WORDPRESS_ADMIN_USERNAME'));
        $this->minkContext->fillField('pwd', getenv('WORDPRESS_ADMIN_PASSWORD'));
        $this->minkContext->pressButton('wp-submit');
        $this->minkContext->assertPageAddress("wp-admin/");
    }

    /**
     * Fills in form field with specified id|name|label|value
     * Example: When I fill in "admin_password2" with the command line global variable: "WORDPRESS_ADMIN_PASSWORD"
     *
     * @When I fill in :arg1 with the command line global variable: :arg2
     */
    public function fillFieldWithGlobal($field, $value)
    {
        $this->minkContext->fillField($field, getenv($value));
    }

    /**
     * Submits the form matching a CSS selector, without pressing a button.
     *
     * Example: When I submit the ".wrap form" form
     *
     * Needed on wp-admin settings pages under the browserkit driver. The
     * site icon block in wp-admin/options-general.php emits one more
     * </div> than it opens. The HTML5 parser that DomCrawler now uses
     * (masterminds/html5) unwinds past the enclosing <form> to balance
     * that, so the submit button is reparented outside the form and the
     * driver throws "The selected node does not have a form ancestor".
     * The goutte driver parsed with libxml, which tolerated the
     * imbalance, so a plain `I press` worked before the driver swap.
     *
     * Note that scoping a button lookup to the form does not help: once
     * the button is reparented it is no longer a descendant of the form.
     * Submitting the form element itself does work, and the form still
     * carries its own fields.
     *
     * @When I submit the :element form
     */
    public function submitFormElement($element)
    {
        $form = $this->minkContext->getSession()->getPage()->find('css', $element);

        if (null === $form) {
            throw new \Exception(sprintf('Form "%s" not found on the page.', $element));
        }

        $form->submit();
    }
}
