<?php

namespace PantheonSystems\PantheonWordPressUpstreamTests\Behat;

use Behat\Behat\Context\Context;

class PantheonWordPressUpstreamContext implements Context
{

	/**
	 * Initializes context.
	 *
	 * Every scenario gets its own context instance.
	 * You can also pass arbitrary arguments to the
	 * context constructor through behat.yml.
	 */
	public function __construct()
	{
	}

	/**
	 * Waits a certain number of seconds.
	 *
	 * @param int $seconds
	 *   How long to wait.
	 *
	 * @When I wait :seconds second(s)
	 */
	public function wait($seconds)
	{
		sleep($seconds);
	}

}