<?php
// features/bootstrap/Wait.php

namespace behat\features\bootstrap;

use Behat\Behat\Context\Context;

class Wait implements Context
{
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