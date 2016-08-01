<?php

use Behat\Behat\Context\Context;
use Behat\Behat\Context\SnippetAcceptingContext;
use Behat\MinkExtension\Context\MinkContext;
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
        $this->minkContext = $environment->getContext('Behat\MinkExtension\Context\MinkContext');
    }    
    
    /**
     * @Given I log in as an admin
     */
    public function ILogInAsAnAdimin()
    {
        $this->minkContext->visit('wp-login.php');
        $this->minkContext->fillField('log', 'pantheon');
        $this->minkContext->fillField('pwd', 'pantheon');
        $this->minkContext->pressButton('wp-submit');
        $this->minkContext->assertPageAddress("wp-admin/");
    }
}
