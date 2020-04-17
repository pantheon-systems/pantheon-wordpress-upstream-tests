# pantheon-wordpress-upstream

Runs a Behat-based test suite against a given branch of the [Pantheon WordPress upstream](https://github.com/pantheon-systems/wordpress) on [Pantheon](https://pantheon.io/) infrastructure to ensure the branch is fully functional on Pantheon.

[![CircleCI](https://circleci.com/gh/pantheon-systems/pantheon-wordpress-upstream-tests.svg?style=svg)](https://circleci.com/gh/pantheon-systems/pantheon-wordpress-upstream-tests)

## How It Works

The purpose of this repository is to ensure a given branch of the Pantheon WordPress Upstream is fully functional on Pantheon infrastructure. This is used as a part of Pantheon's automated WordPress updating process.

On a high level, here's how it works:

1. A new CircleCI job is [initiated through a cron job](https://circleci.com/docs/nightly-builds/), or when a push is made against the WordPress upstream.
2. The job environment defines three important environment variables:
 * `TERMINUS_TOKEN` - A [machine token](https://pantheon.io/docs/machine-tokens/) used for creating and deleting site environments on Pantheon. Because this token is meant to be kept secret, the value is set in the CircleCI admin, and not tracked in `circle.yml`.
 * `TERMINUS_SITE` - An existing Pantheon site to be used for running the test suite. This site must support [multidev](https://pantheon.io/features/multidev-cloud-environments), and the `TERMINUS_TOKEN` must be able to create and delete environments for this site.
 * `TERMINUS_ENV` - A unique name for the multidev branch to be created, to prevent collisions between jobs.
3. CircleCI installs [Terminus](https://pantheon.io/docs/terminus/), an interface for programmatically interacting with Pantheon.
4. The test suite runs in three steps:
 1. [`prepare.sh`](https://github.com/pantheon-systems/pantheon-wordpress-upstream/blob/master/prepare.sh) - Prepares the Pantheon site environment to have the test suite run against it. Preparation includes:
    * Creating the site environment using Terminus.
 2. [`test.sh`](https://github.com/pantheon-systems/pantheon-wordpress-upstream/blob/master/test.sh) - Runs the Behat test suite against the created environment.
 3. [`cleanup.sh`](https://github.com/pantheon-systems/pantheon-wordpress-upstream/blob/master/cleanup.sh) - Cleans up after the test suite has completed. Cleanup includes:
    * Deleting the site environment using Terminus.

And that's it!

## Making Improvements

Need to improve this test runner in some way? You can clone the repository locally and run it against any Pantheon site.

**WARNING! WARNING!**

**PLEASE READ THE FOLLOWING VERY CAREFULLY.**

**BY FORCE PUSHING AGAINST `TERMINUS_ENV` AND ERASING THE DATABASE, THIS TEST RUNNER IRREVOCABLY DAMAGES YOUR PANTHEON SITE. USE ONLY WITH A SINGLE-USE, "THROWAWAY" SITE. DO NOT USE WITH ANY PANTHEON SITE THAT CANNOT BE DELETED.** 

With the warning out of the way, here's how you can use the test runner locally.

First, make sure Terminus is installed and authenticated:

    composer global require pantheon-systems/terminus
    terminus auth login --machine-token=<secret-token>

Then, you can clone and use the test runner:

    git clone git@github.com:pantheon-systems/pantheon-wordpress-upstream-tests.git
    cd pantheon-wordpress-upstream-tests
    export TERMINUS_SITE=wordpress-upstream
    export TERMINUS_ENV=test-1
    export WORDPRESS_ADMIN_USERNAME=pantheon
    export WORDPRESS_ADMIN_PASSWORD="$(openssl rand -hex 8)"
    ./prepare.sh
    ./test.sh
    ./cleanup.sh

Feel free to [open an issue](https://github.com/pantheon-systems/pantheon-wordpress-upstream/issues) with any questions you may have.

